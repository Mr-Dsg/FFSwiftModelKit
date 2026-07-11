// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFSwiftModelKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "FFSwiftModelKit",
            targets: ["FFSwiftModelKit"]
        )
    ],
    targets: [
        .target(
            name: "FFSwiftModelKit",
            path: "Sources/FFSwiftModelKit"
        ),
        .testTarget(
            name: "FFSwiftModelKitTests",
            dependencies: ["FFSwiftModelKit"],
            path: "Tests/FFSwiftModelKitTests"
        )
    ],
    swiftLanguageModes: [
        .v6
    ]
)
