// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version: 6.2

// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Login",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Login",
            targets: ["Login"]
        ),
    ],
    dependencies: [
        .package(path: "../../Foundation/Firebase"),
        .package(path: "../../Core/CommonUI"),
        .package(path: "../../Foundation/Router"),
        .package(path: "../../Presentation/AppCoordinator.swift")
    ],
    targets: [
        .target(
            name: "Login",
            dependencies: [
                .product(name: "PFirebase", package: "Firebase"),
                "CommonUI",
                "Router",
                "AppCoordinator.swift"
            ]
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]
        ),
    ]
)
