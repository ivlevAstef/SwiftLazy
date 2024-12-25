//
//  BaseLazy.swift
//  SwiftLazy
//
//  Created by Ивлев Александр Евгеньевич on 27/09/2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//

import Dispatch

public class BaseThreadSaveLazy<Value>: @unchecked Sendable {

  /// `true` if `self` was previously made.
  public var wasMade: Bool {
    pthread_rwlock_rdlock(&lock)
    defer { pthread_rwlock_unlock(&lock) }
    return cache != nil
  }

  init() {
      pthread_rwlock_init(&lock, &attr)
  }

  deinit {
    pthread_rwlock_destroy(&lock)
  }

  /// clears the stored value.
  public func clear() {
    pthread_rwlock_wrlock(&lock)
    defer { pthread_rwlock_unlock(&lock) }
    cache = nil
  }

  internal func getValue(_ initializer: () -> Value) -> Value {
    pthread_rwlock_rdlock(&lock)
    if let cache {
      pthread_rwlock_unlock(&lock)
      return cache
    }
    pthread_rwlock_unlock(&lock)

    pthread_rwlock_wrlock(&lock)
    defer { pthread_rwlock_unlock(&lock) }

    if let cache {
        return cache
    }

    let result = initializer()
    cache = result

    return result
  }

  private var lock = pthread_rwlock_t()
  private var attr = pthread_rwlockattr_t()
  private var cache: Value?
}

extension BaseThreadSaveLazy: CustomStringConvertible, CustomDebugStringConvertible {

  /// A textual representation of this instance.
  public var description: String {
    let cache = self.cache
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    return "Lazy(\(value))"
  }

  /// A textual representation of this instance, suitable for debugging.
  public var debugDescription: String {
    let cache = self.cache
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    return "Lazy(\(value): \(Value.self))"
  }
}
