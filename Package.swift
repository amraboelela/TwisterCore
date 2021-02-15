// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TwisterCore",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "TwisterCore",
            targets: ["TwisterCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/amraboelela/SwiftBoost", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "TwisterCore", dependencies: ["twisterd"]),
        .target(name: "twisterd", dependencies: ["bitcoin"]),
        .target(name: "bitcoin", dependencies: ["SwiftBoost"]),
        //.target(name: "bitcoin", dependencies: ["SwiftLevelDB"]),
        .testTarget(name: "TwisterCoreTests", dependencies: ["TwisterCore"]),
    ]
)
