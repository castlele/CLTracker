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
        .package(url: "https://github.com/castlele/CLArgumentsParser.git", .revision("9abcf6c1b6d7ec1b41fbab7ec9db1513719c86ad")),
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
