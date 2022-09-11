// swift-tools-version:5.5.0

import PackageDescription

let package = Package(
    name: "CLTracker",
    platforms: [
        .macOS(.v12),
    ],
    products: [
        .executable(name: "tracker", targets: ["CLTracker"])
    ],
    dependencies: [
        .package(url: "git@github.com:castlele/CLArgumentsParser.git", .revision("86ef49d6dc9b27f7027cdb048892f06bb7eb87aa")),
    ],
    targets: [
        .executableTarget(
            name: "CLTracker",
            dependencies: ["CLArgumentsParser"]),
        .testTarget(
            name: "CLTrackerTests",
            dependencies: ["CLTracker"]),
    ]
)
