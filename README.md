[![CocoaPods Version](https://img.shields.io/cocoapods/v/SwiftLazy.svg?style=flat)](http://cocoapods.org/pods/SwiftLazy)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/github/license/ivlevAstef/SwiftLazy.svg?maxAge=2592000)](http://cocoapods.org/pods/SwiftLazy)
[![Swift Version](https://img.shields.io/badge/Swift-3.0--5.8-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-lightgrey.svg)](http://cocoapods.org/pods/SwiftLazy)

# SwiftLazy
Swift allows for lazy variables out-of-the-box, however they're fairly restricted.

## Features
* Lazy and Provider operations
* Short syntax
* Thread safe

## Usage

### Lazy

```Swift
let lazyInt = Lazy(1)
print(lazyInt.wasMade)  // false
print(lazyInt.value) // 1
print(lazyInt.wasMade)  // true
```

Support arithmetic operations:
```Swift
let lazyInt = Lazy<Int>{ 1 + 2 * 5 } * 4 + 10
print(lazyInt.wasMade)  // false
print(lazyInt.value) // 54
print(lazyInt.wasMade)  // true
```

Short syntax:
```Swift
let lazyInt = Lazy(1)
print(*lazyInt) // 1
```

### Provider

```Swift
let providerInt = Provider(1)
print(lazyInt.value) // 1
```

Support arithmetic operations:
```Swift
let providerInt = Provider<Int>{ 1 + 2 * 5 } * 4 + 10
print(providerInt.value) // 54
```

Short syntax:
```Swift
let providerInt = Provider(1)
print(*providerInt) // 1
```

### Difference Lazy vs Provider

```Swift
var counter: Int = 0
let lazyInt = Lazy<Int> {
  counter += 1
  return counter
}

print(lazyInt.value) // 1
print(lazyInt.value) // 1
print(lazyInt.value) // 1

lazyInt.clear() // no provider
print(lazyInt.value) // 2
print(lazyInt.value) // 2
print(lazyInt.value) // 2
```

```Swift
var counter: Int = 0
let providerInt = Provider<Int> {
counter += 1
return counter
}

print(providerInt.value) // 1
print(providerInt.value) // 2
print(providerInt.value) // 3
```

### Version 1.1.0

Add Provider with arguments:
```Swift
let provider = Provider2<String, Int, Double> { "\($0) + \($1) = \($0 + $1)" }

print(provider.value(10, 20.0)) // "10 + 20.0 = 30.0"
```
Support 1, 2, 3, 4, 5 arguments count.

## Install
###### Via CocoaPods.

To install SwiftLazy with CocoaPods, add the following lines to your Podfile: `pod 'SwiftLazy'`

###### Via Carthage.
github "ivlevAstef/SwiftLazy" 

### The library is integrated with DITranquillity

## Requirements
iOS 11.0+,macOS 10.13+,tvOS 11.0+, watchOS 4.0+, Linux; ARC

## Feedback

### I've found a bug, or have a feature request
Please raise a [GitHub issue](https://github.com/ivlevAstef/SwiftLazy/issues).

### Question?
You can feel free to ask the question at e-mail: ivlev.stef@gmail.com.
