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
        .package(url: "git@github.com:castlele/CLArgumentsParser.git", .revision("d1cef29cdda2a150ae4df0ca6a8883dd8ce1ee32")),
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
