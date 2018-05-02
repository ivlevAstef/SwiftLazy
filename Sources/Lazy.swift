//
//  Lazy.swift
//  SwiftLazy
//
//  Created by Alexander Ivlev on 08.04.2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//

import Foundation

public final class Lazy<Value> {

  /// The value for `self`.
  ///
  /// Getting the value or made and return.
  public var value: Value {
    get {
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
  }

  private var monitor: DispatchSemaphore = DispatchSemaphore(value: 1)
  private var fastMonitor: FastLock = makeFastLock()

  fileprivate var cache: Value?
  private var initializer: () -> Value

  /// Create a lazy value.
  public init(_ initializer: @autoclosure @escaping () -> Value) {
    self.initializer = initializer
  }

  /// Create a lazy value.
  public init(_ initializer: @escaping () -> Value) {
    self.initializer = initializer
  }

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
}


public extension Lazy {

  /// Maps `transform` over `value` and returns a lazy result.
  public func map<T>(_ transform: @escaping (Value) -> T) -> Lazy<T> {
    return Lazy<T> { () -> T in
      return transform(self.value)
    }
  }
}

prefix operator *

/// Fast syntax for getting the value for Lazy.
public prefix func *<T>(_ wrapper: Lazy<T>) -> T {
  return wrapper.value
}


extension Lazy: CustomStringConvertible, CustomDebugStringConvertible {
  
  /// A textual representation of this instance.
  public var description: String {
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    return "Lazy(\(value))"
  }

  /// A textual representation of this instance, suitable for debugging.
  public var debugDescription: String {
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    return "Lazy(\(value): \(Value.self))"
  }
}

/// MARK: Compare

public func == <T: Equatable, Type: Lazy<T>>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<Bool> {
  return Lazy(lhs.value == rhs.value)
}

public func == <T: Equatable>(lhs: Lazy<T>, rhs: T) -> Lazy<Bool> {
  return Lazy(lhs.value == rhs)
}

public func == <T: Equatable>(lhs: T, rhs: Lazy<T>) -> Lazy<Bool> {
  return Lazy(lhs == rhs.value)
}

/// MARK: Operations

public func - <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value - rhs.value)
}

public func - <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value - rhs)
}

public func - <T: BinaryInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs - rhs.value)
}

public func + <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value + rhs.value)
}

public func + <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value + rhs)
}

public func + <T: BinaryInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs + rhs.value)
}

public func * <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value * rhs.value)
}

public func * <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value * rhs)
}

public func * <T: BinaryInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs * rhs.value)
}

public func / <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value / rhs.value)
}

public func / <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value / rhs)
}

public func / <T: BinaryInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs / rhs.value)
}

public func % <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value % rhs.value)
}

public func % <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value % rhs)
}

public func % <T: BinaryInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs % rhs.value)
}

public func & <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value & rhs.value)
}

public func & <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value & rhs)
}

public func & <T: BinaryInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs & rhs.value)
}

public func | <T: BinaryInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value | rhs.value)
}

public func | <T: BinaryInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value | rhs)
}

public func | <T: FixedWidthInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs | rhs.value)
}

public func ^ <T: FixedWidthInteger>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs.value ^ rhs.value)
}

public func ^ <T: FixedWidthInteger>(lhs: Lazy<T>, rhs: T) -> Lazy<T> {
  return Lazy(lhs.value ^ rhs)
}

public func ^ <T: FixedWidthInteger>(lhs: T, rhs: Lazy<T>) -> Lazy<T> {
  return Lazy(lhs ^ rhs.value)
}

public prefix func ~ <T: FixedWidthInteger>(x: Lazy<T>) -> Lazy<T> {
  return Lazy(~x.value)
}
