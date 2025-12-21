// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Router",
            targets: ["Router"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hhru/Nivelir.git", from: "1.9.10"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Router",
            dependencies: [
                .product(name: "Nivelir", package: "nivelir"),
            ]
        ),
        .testTarget(
            name: "RouterTests",
            dependencies: ["Router"]
        ),
    ]
)
