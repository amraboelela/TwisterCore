// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "twistercore",
    products: [
        .library(
            name: "twistercore",
            targets: ["twistercore"])
    ],
    dependencies: [
        .package(url: "https://github.com/amraboelela/boost", .branch("master")),
        //.package(url: "https://github.com/amraboelela/openssl", .branch("master")),
        .package(url: "https://github.com/amraboelela/leveldb", .branch("master")),
    ],
    targets: [
        //.target(name: "twistercore", dependencies: ["boost", "openssl", "leveldb", "memenv"]),
        //.target(name: "memenv", dependencies: ["leveldb"]),
        .target(name: "twistercore", dependencies: ["boost", "leveldb"]),
    ]
)
