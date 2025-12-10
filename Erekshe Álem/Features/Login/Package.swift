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
        .package(path: "../../Foundation/Firebase")
    ],
    targets: [
        .target(
            name: "Login",
            dependencies: [
//                "PFirebase"
                .product(name: "PFirebase", package: "Firebase")
            ]
        ),
        .testTarget(
            name: "LoginTests",
            dependencies: ["Login"]
        ),
    ]
)
