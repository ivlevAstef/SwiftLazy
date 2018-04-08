//
//  Lazy.swift
//  SwiftLazy
//
//  Created by Alexander Ivlev on 08.04.2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//

public final class Lazy<Value> {

  public var value: Value {
    get {
      monitor.wait()
      let result = cache ?? initializer()
      cache = result
      monitor.signal()
      return result
    }
  }

  private var monitor: DispatchSemaphore = DispatchSemaphore(value: 1)
  private var cache: Value?
  private var initializer: () -> Value

  public init(_ initializer: @autoclosure @escaping () -> Value) {
    self.initializer = initializer
  }

  public init(_ initializer: @escaping () -> Value) {
    self.initializer = initializer
  }

  public var isMade: Bool {
    return cache != nil
  }
}


public extension Lazy {
  public func map<T>(_ transform: @escaping (Value) -> T) -> Lazy<T> {
    return Lazy<T> { () -> T in
      return transform(self.value)
    }
  }
}

prefix operator *
public prefix func *<T>(_ wrapper: Lazy<T>) -> T {
  return wrapper.value
}


extension Lazy: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    return "Lazy(\(value))"
  }

  public var debugDescription: String {
    let value = cache.flatMap(String.init(describing:)) ?? "nil"
    return "Lazy(\(value): \(Value.self))"
  }
}


public func == <T: Equatable, Type: Lazy<T>>(lhs: Lazy<T>, rhs: Lazy<T>) -> Lazy<Bool> {
  return Lazy(lhs.value == rhs.value)
}

public func == <T: Equatable>(lhs: Lazy<T>, rhs: T) -> Lazy<Bool> {
  return Lazy(lhs.value == rhs)
}

public func == <T: Equatable>(lhs: T, rhs: Lazy<T>) -> Lazy<Bool> {
  return Lazy(lhs == rhs.value)
}


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
