// swift-tools-version:5.9
import PackageDescription

let package = Package(
  name: "SwiftLazy",
  platforms: [.iOS(.v13), .watchOS(.v8), .macOS(.v10_15), .tvOS(.v13)],
  products: [.library(name: "SwiftLazy", targets: ["SwiftLazy"])],
  targets: [.target(name: "SwiftLazy", dependencies: [])]
)
