//
//  BaseProvider.swift
//  SwiftLazy
//
//  Created by Ивлев Александр Евгеньевич on 27/09/2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//


internal class BaseProvider<Value> {

  /// The value for `self`.
  ///
  /// Made the value and return.
  internal func getValue(_ initializer: () -> Value) -> Value {
    return initializer()
  }

}

extension BaseProvider: CustomStringConvertible, CustomDebugStringConvertible {

  /// A textual representation of this instance.
  public var description: String {
    return "Provider(\(Value.self))"
  }

  /// A textual representation of this instance, suitable for debugging.
  public var debugDescription: String {
    return "Provider(\(Value.self))"
  }
}
