// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "MXPostMessageDefinitions",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "MXPostMessageDefinitions", targets: ["MXPostMessageDefinitions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", from: "5.0.0"),
        .package(name: "Mockingbird", url: "https://github.com/birdrides/mockingbird", from: "0.19.0"),
    ],
    targets: [
        .target(
            name: "MXPostMessageDefinitions",
            path: "Sources"
        ),
        .testTarget(
            name: "MXPostMessageDefinitionsTests",
            dependencies: [
                "MXPostMessageDefinitions",
                "Quick",
                "Mockingbird"
            ],
            path: "Tests"
        ),
    ],
    swiftLanguageVersions: [
        .v5,
    ]
)
