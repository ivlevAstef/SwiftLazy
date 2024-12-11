//
//  ProviderArgs.swift
//  SwiftLazy
//
//  Created by Ивлев Александр Евгеньевич on 27/09/2018.
//  Copyright © 2018 Alexander Ivlev. All rights reserved.
//

public final class Provider1<Value, Arg1>: BaseProvider<Value>, @unchecked Sendable {
  public func value(_ arg1: Arg1) -> Value {
    return self.getValue { return self.initializer(arg1) }
  }

  private var initializer: (Arg1) -> Value

  public init(_ initializer: @escaping (Arg1) -> Value) {
    self.initializer = initializer
  }
}

public final class Provider2<Value, Arg1, Arg2>: BaseProvider<Value>, @unchecked Sendable {
  public func value(_ arg1: Arg1, _ arg2: Arg2) -> Value {
    return self.getValue { return self.initializer(arg1, arg2) }
  }

  private var initializer: (Arg1, Arg2) -> Value

  public init(_ initializer: @escaping (Arg1, Arg2) -> Value) {
    self.initializer = initializer
  }
}

public final class Provider3<Value, Arg1, Arg2, Arg3>: BaseProvider<Value>, @unchecked Sendable {
  public func value(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3) -> Value {
    return self.getValue { return self.initializer(arg1, arg2, arg3) }
  }

  private var initializer: (Arg1, Arg2, Arg3) -> Value

  public init(_ initializer: @escaping (Arg1, Arg2, Arg3) -> Value) {
    self.initializer = initializer
  }
}

public final class Provider4<Value, Arg1, Arg2, Arg3, Arg4>: BaseProvider<Value>, @unchecked Sendable {
  public func value(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4) -> Value {
    return self.getValue { return self.initializer(arg1, arg2, arg3, arg4) }
  }

  private var initializer: (Arg1, Arg2, Arg3, Arg4) -> Value

  public init(_ initializer: @escaping (Arg1, Arg2, Arg3, Arg4) -> Value) {
    self.initializer = initializer
  }
}

public final class Provider5<Value, Arg1, Arg2, Arg3, Arg4, Arg5>: BaseProvider<Value>, @unchecked Sendable {
  public func value(_ arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3, _ arg4: Arg4, _ arg5: Arg5) -> Value {
    return self.getValue { return self.initializer(arg1, arg2, arg3, arg4, arg5) }
  }

  private var initializer: (Arg1, Arg2, Arg3, Arg4, Arg5) -> Value

  public init(_ initializer: @escaping (Arg1, Arg2, Arg3, Arg4, Arg5) -> Value) {
    self.initializer = initializer
  }
}
