// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftTwisterCore",
    products: [
        .library(name: "SwiftTwisterCore", targets: ["CTwisterCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/amraboelela/jsoncpp", .branch("master")),
        .package(url: "https://github.com/amraboelela/openssl", .branch("master")),
        .package(url: "https://github.com/amraboelela/leveldb", .branch("master")),
        .package(url: "https://github.com/amraboelela/boost", .branch("master")),
    ],
    targets: [
        //.target(name: "twistercore", dependencies: ["boost", "openssl", "leveldb", "memenv"]),
        //.target(name: "memenv", dependencies: ["leveldb"]),
        //.target(name: "SwiftTwisterCore", dependencies: ["CTwisterCore"]),
        .target(name: "CTwisterCore", dependencies: ["twistercore"]),
        .target(name: "twistercore", dependencies: ["bitcoinleveldb", "jsoncpp", "openssl"]),
        //.target(name: "twistertorrent", dependencies: ["bitcoinleveldb"]),
        .target(name: "bitcoinleveldb", dependencies: ["leveldb", "boost"]),
        //.target(name: "twistercore_macos", dependencies: ["boost", "openssl"])
        //.target(name: "twistercore", dependencies: ["boost", "openssl", "leveldb"]),
        //.testTarget(name: "SwiftTwisterCoreTests", dependencies: ["SwiftTwisterCore"]),
    ]
)
