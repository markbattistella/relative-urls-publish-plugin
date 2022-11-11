// swift-tools-version:5.1

// RelativeUrls plugin for Publish
// Copyright (c) Mark Battistella 2022
// MIT license - see LICENSE for details

import PackageDescription

let package = Package(
	name: "RelativeUrls",
	products: [
		.library(
			name: "RelativeUrls",
			targets: ["RelativeUrls"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
	],
	targets: [
		.target(
			name: "RelativeUrls",
			dependencies: ["Publish"]
		)
	]
)
