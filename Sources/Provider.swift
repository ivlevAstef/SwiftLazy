//
//  Provider.swift
//  SwiftLazy
//
//  Created by Alexander Ivlev on 08.04.2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//

public final class Provider<Value> {

  /// The value for `self`.
  ///
  /// Made the value and return.
  public var value: Value {
    get {
      return initializer()
    }
  }

  private var initializer: () -> Value

  /// Create a provider value.
  public init(_ initializer: @autoclosure @escaping () -> Value) {
    self.initializer = initializer
  }

  /// Create a provider value.
  public init(_ initializer: @escaping () -> Value) {
    self.initializer = initializer
  }
}


public extension Provider {

  /// Maps `transform` over `value` and returns a provider result.
  public func map<T>(_ transform: @escaping (Value) -> T) -> Provider<T> {
    return Provider<T> { () -> T in
      return transform(self.value)
    }
  }
}

prefix operator *

/// Fast syntax for getting the value for Lazy.
public prefix func *<T>(_ wrapper: Provider<T>) -> T {
  return wrapper.value
}


extension Provider: CustomStringConvertible, CustomDebugStringConvertible {

  /// A textual representation of this instance.
  public var description: String {
    return "Provider(\(Value.self))"
  }

  /// A textual representation of this instance, suitable for debugging.
  public var debugDescription: String {
    return "Provider(\(Value.self))"
  }
}

/// MARK: Compare

public func == <T: Equatable, Type: Provider<T>>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<Bool> {
  return Provider(lhs.value == rhs.value)
}

public func == <T: Equatable>(lhs: Provider<T>, rhs: T) -> Provider<Bool> {
  return Provider(lhs.value == rhs)
}

public func == <T: Equatable>(lhs: T, rhs: Provider<T>) -> Provider<Bool> {
  return Provider(lhs == rhs.value)
}

/// MARK: Operations

public func - <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value - rhs.value)
}

public func - <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value - rhs)
}

public func - <T: BinaryInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs - rhs.value)
}

public func + <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value + rhs.value)
}

public func + <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value + rhs)
}

public func + <T: BinaryInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs + rhs.value)
}

public func * <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value * rhs.value)
}

public func * <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value * rhs)
}

public func * <T: BinaryInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs * rhs.value)
}

public func / <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value / rhs.value)
}

public func / <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value / rhs)
}

public func / <T: BinaryInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs / rhs.value)
}

public func % <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value % rhs.value)
}

public func % <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value % rhs)
}

public func % <T: BinaryInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs % rhs.value)
}

public func & <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value & rhs.value)
}

public func & <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value & rhs)
}

public func & <T: BinaryInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs & rhs.value)
}

public func | <T: BinaryInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value | rhs.value)
}

public func | <T: BinaryInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value | rhs)
}

public func | <T: FixedWidthInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs | rhs.value)
}

public func ^ <T: FixedWidthInteger>(lhs: Provider<T>, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs.value ^ rhs.value)
}

public func ^ <T: FixedWidthInteger>(lhs: Provider<T>, rhs: T) -> Provider<T> {
  return Provider(lhs.value ^ rhs)
}

public func ^ <T: FixedWidthInteger>(lhs: T, rhs: Provider<T>) -> Provider<T> {
  return Provider(lhs ^ rhs.value)
}

public prefix func ~ <T: FixedWidthInteger>(x: Provider<T>) -> Provider<T> {
  return Provider(~x.value)
}

