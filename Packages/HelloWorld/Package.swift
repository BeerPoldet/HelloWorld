// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HelloWorld",
  defaultLocalization: "en",
  platforms: [.iOS(.v14), .macOS(.v10_15)],
  products: [
    // MARK: Core Library

    .library(name: "Config", targets: ["Config"]),
    .library(name: "ComposableArchitectureExt", targets: ["ComposableArchitectureExt"]),
    .library(name: "Resource", targets: ["Resource"]),
    .library(name: "Bundle", targets: ["Bundle"]),

    // MARK: Client Libraries

    // MARK: Feature Library

    .library(
      name: "AppFeature",
//      type: .dynamic,
      targets: ["AppFeature"]
    ),
  ],
  dependencies: [
    .package(
      name: "Introspect",
      url: "https://github.com/siteline/SwiftUI-Introspect.git",
      from: "0.1.3"
    ),
    .package(
      name: "Overture",
      url: "https://github.com/pointfreeco/swift-overture.git",
      from: "0.5.0"
    ),
    .package(
      name: "Prelude",
      url: "https://github.com/pointfreeco/swift-prelude.git",
      .revision("8bff642")
    ),
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.9.0"
    ),
    .package(
      name: "swift-case-paths",
      url: "https://github.com/pointfreeco/swift-case-paths.git",
      from: "0.5.0"
    ),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      from: "0.22.0"
    ),
  ],
  targets: [
    // MARK: - Core Target

    .target(name: "Bundle"),
    .target(name: "Config"),
    .target(
      name: "ComposableArchitectureExt",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "Resource",
      dependencies: ["Bundle"],
      exclude: [
        "Stencils",
        "swiftgen.yml",
      ],
      resources: [.process("Colors"), .process("Images"), .process("L10N")]
    ),

    // MARK: - Client Target

    // MARK: - Feature Target

    // MARK: App

    .target(
      name: "AppFeature",
      dependencies: [
        "Config",
        "ComposableArchitectureExt",
        "Resource",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "CasePaths", package: "swift-case-paths"),
        .product(name: "Introspect", package: "Introspect"),
        .product(name: "Overture", package: "Overture"),
        .product(name: "Prelude", package: "Prelude"),
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: [
        "AppFeature",
        .product(name: "SnapshotTesting", package: "SnapshotTesting"),
      ],
      exclude: ["__Snapshots__"]
    ),
  ]
)
