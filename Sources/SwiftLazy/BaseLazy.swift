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
    return cache != nil
  }

  /// clears the stored value.
  public func clear() {
    cache = nil
  }

  internal func getValue(_ initializer: () -> Value) -> Value {
    if let cache = cache {
      return cache
    }

    monitor.wait()
    defer { monitor.signal() }

    if let cache = cache {
        return cache
    }

    let result = initializer()
    cache = result

    return result
  }

  private let monitor: DispatchSemaphore = DispatchSemaphore(value: 1)
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
