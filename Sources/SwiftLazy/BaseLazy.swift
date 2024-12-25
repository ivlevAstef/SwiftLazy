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
    lock.readLock()
    defer { lock.unlock() }
    return cache != nil
  }

  /// clears the stored value.
  public func clear() {
    lock.writeLock()
    defer { lock.unlock() }
    cache = nil
  }

  internal func getValue(_ initializer: () -> Value) -> Value {
    lock.readLock()
    if let cache {
      lock.unlock()
      return cache
    }
    lock.unlock()

    lock.writeLock()
    defer { lock.unlock() }

    if let cache {
      return cache
    }

    let result = initializer()
    cache = result

    return result
  }

  private let lock = RWLock()

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

private final class RWLock {
  private var lock = pthread_rwlock_t()

  init() {
    pthread_rwlock_init(&lock, nil)
  }

  deinit {
    pthread_rwlock_destroy(&lock)
  }

  func writeLock() {
    pthread_rwlock_wrlock(&lock)
  }

  func readLock() {
    pthread_rwlock_rdlock(&lock)
  }

  func unlock() {
    pthread_rwlock_unlock(&lock)
  }
}
