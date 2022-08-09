// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "MXPostMessageDefinitions",
    platforms: [.iOS(.v12)],
    targets: [
        .target(
            name: "MXPostMessageDefinitions",
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
