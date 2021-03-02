// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "InstantSearchVoiceOverlay",
  platforms: [
    .iOS(.v10),
  ],
  products: [
    .library(
      name: "InstantSearchVoiceOverlay",
      targets: ["InstantSearchVoiceOverlay"]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "InstantSearchVoiceOverlay",
      dependencies: [],
      resources: [.copy("Sound")]
    ),
    .testTarget(
      name: "InstantSearchVoiceOverlayTests",
      dependencies: ["InstantSearchVoiceOverlay"]),
  ]
)
