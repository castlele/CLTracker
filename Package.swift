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
        .package(url: "git@github.com:castlele/CLArgumentsParser.git", .revision("f1eae48205dcd20a3650ef841ab0e20937a05fb4")),
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
