// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "exmaple-swift-server",
    dependencies: [
      .package(url: "https://github.com/IBM-Swift/Kitura.git", .upToNextMinor(from: "2.0.0")),
      .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", .upToNextMinor(from: "1.7.1")),
      .package(url: "https://github.com/IBM-Swift/CloudEnvironment.git", .upToNextMinor(from: "4.0.5")),
      .package(url: "https://github.com/IBM-Swift/Configuration.git", .upToNextMinor(from: "1.0.0")),
      .package(url: "https://github.com/IBM-Swift/SwiftyJSON.git", from: "17.0.0"),
      .package(url: "https://github.com/RuntimeTools/SwiftMetrics.git", from: "2.0.0"),
      .package(url: "https://github.com/IBM-Swift/Health.git", from: "0.0.0"),
    ],
    targets: [
      .target(name: "exmaple-swift-server", dependencies: [ .target(name: "Application"), "Kitura" , "HeliumLogger"]),
      .target(name: "Application", dependencies: [ "Kitura", "Configuration", "CloudEnvironment","SwiftMetrics","Health",.target(name: "Generated"),
      ]),
      .target(name: "Generated", dependencies: ["Kitura","Configuration", "CloudEnvironment","SwiftyJSON", "SwiftMetrics","Health",], path: "Sources/Generated"),

      .testTarget(name: "ApplicationTests" , dependencies: [.target(name: "Application"), "Kitura","HeliumLogger" ])
    ]
)
