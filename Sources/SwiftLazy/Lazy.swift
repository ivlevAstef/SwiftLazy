//
//  Lazy.swift
//  SwiftLazy
//
//  Created by Alexander Ivlev on 08.04.2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//

public final class Lazy<Value>: BaseThreadSaveLazy<Value> {

  /// The value for `self`.
  ///
  /// Getting the value or made and return.
  public var value: Value {
    get {
      return self.getValue(self.initializer)
    }
  }

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
  public override var wasMade: Bool { return super.wasMade }

  /// clears the stored value.
  public override func clear() { super.clear() }
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
