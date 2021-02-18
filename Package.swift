// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TwisterCore",
    products: [
        .library(
            name: "TwisterCore",
            targets: ["TwisterCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/amraboelela/boost", .branch("main")),
        .package(url: "https://github.com/amraboelela/openssl", .branch("master")),
        .package(url: "https://github.com/amraboelela/leveldb", .branch("main")),
    ],
    targets: [
        .target(name: "TwisterCore", dependencies: ["boost", "openssl", "leveldb", "memenv"]),
        .target(name: "memenv", dependencies: ["leveldb"]),
    ]
)
