// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "NavigationController",
  platforms: [
    .macOS(.v10_10)
  ],
  products: [
    .library(
      name: "NavigationController",
      targets: ["NavigationController"]),
  ],
  targets: [
    .target(
      name: "NavigationController",
      dependencies: [])
  ]
)
