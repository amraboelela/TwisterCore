// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "twistercore",
    products: [
        .library(name: "twistercore", targets: ["twistercore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/amraboelela/jsoncpp", .branch("master")),
        .package(url: "https://github.com/amraboelela/openssl", .branch("master")),
        .package(url: "https://github.com/amraboelela/leveldb", .branch("master")),
        .package(url: "https://github.com/amraboelela/boost", .branch("master")),
    ],
    targets: [
        //.target(name: "SwiftTwisterCore", dependencies: ["CTwisterCore"]),
        //.target(name: "CTwisterCore", dependencies: ["twistercore"]),
        .target(name: "twistercore", dependencies: ["bitcoinleveldb", "jsoncpp", "openssl"]),
        .target(name: "bitcoinleveldb", dependencies: ["leveldb", "boost"]),
        //.testTarget(name: "SwiftTwisterCoreTests", dependencies: ["SwiftTwisterCore"]),
    ]
)
