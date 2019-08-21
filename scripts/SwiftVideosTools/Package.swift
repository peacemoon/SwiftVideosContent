// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftVideosTools",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "3.1.0"),
        .package(url: "https://github.com/mtynior/ColorizeSwift.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "SwiftVideosTools",
            dependencies: ["Files", "ColorizeSwift"],
            path: "."),
    ]
)
