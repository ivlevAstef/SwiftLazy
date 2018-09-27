//
//  BaseLazy.swift
//  SwiftLazy
//
//  Created by Ивлев Александр Евгеньевич on 27/09/2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//


internal class BaseThreadSaveLazy<Value> {

  /// `true` if `self` was previously made.
  public var wasMade: Bool {
    fastMonitor.lock()
    defer { fastMonitor.unlock() }
    return cache != nil
  }

  /// clears the stored value.
  public func clear() {
    fastMonitor.lock()
    cache = nil
    fastMonitor.unlock()
  }

  internal func getValue(_ initializer: () -> Value) -> Value {
    fastMonitor.lock()

    if let cache = cache {
      fastMonitor.unlock()
      return cache
    }

    monitor.wait()
    fastMonitor.unlock()

    let result = initializer()

    fastMonitor.lock()
    monitor.signal()

    cache = result

    fastMonitor.unlock()

    return result
  }

  private var monitor: DispatchSemaphore = DispatchSemaphore(value: 1)
  fileprivate var fastMonitor: FastLock = makeFastLock()

  fileprivate var cache: Value?

}

extension BaseThreadSaveLazy: CustomStringConvertible, CustomDebugStringConvertible {

  /// A textual representation of this instance.
  public var description: String {
    fastMonitor.lock()
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    fastMonitor.unlock()
    return "Lazy(\(value))"
  }

  /// A textual representation of this instance, suitable for debugging.
  public var debugDescription: String {
    fastMonitor.lock()
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    fastMonitor.unlock()
    return "Lazy(\(value): \(Value.self))"
  }
}
