// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Profile",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Profile",
            targets: ["Profile"]
        ),
    ],
    dependencies: [
        .package(path: "../../Foundation/Firebase"),
        .package(path: "../../Core/CommonUI"),
        .package(path: "../../Core/DesignSystem"),
        .package(path: "../../Foundation/Router"),
        .package(path: "../../Features/Login"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Profile",
            dependencies: [
                .product(name: "PFirebase", package: "Firebase"),
                "CommonUI",
                "Router",
                "DesignSystem",
                "Login"
            ]
        ),
        .testTarget(
            name: "ProfileTests",
            dependencies: ["Profile"]
        ),
    ]
)
