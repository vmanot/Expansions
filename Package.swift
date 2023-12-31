// swift-tools-version:5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "Expansions",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "Expansions",
            targets: [
                "Expansions",
                "MacroBuilder",
                "SwiftSyntaxUtilities",
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: "509.0.0"),
        .package(url: "https://github.com/vmanot/Swallow.git", branch: "master")
    ],
    targets: [
        .macro(
            name: "ExpansionsMacros",
            dependencies: [
                "Swallow",
                .product(name: "SwiftDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftOperators", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftParserDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "SwiftSyntaxUtilities",
            ],
            path: "Sources/ExpansionsMacros"
        ),
        .macro(
            name: "MacroBuilderCompilerPlugin",
            dependencies: [
                "MacroBuilderCore",
                "Swallow"
            ],
            path: "Sources/MacroBuilderCompilerPlugin"
        ),
        .target(
            name: "Expansions",
            dependencies: [
                "ExpansionsMacros",
                "Swallow"
            ],
            path: "Sources/Expansions"
        ),
        .target(
            name: "MacroBuilder",
            dependencies: [
                "Expansions",
                "MacroBuilderCore",
                "Swallow",
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftOperators", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftParserDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ],
            path: "Sources/MacroBuilder"
        ),
        .target(
            name: "MacroBuilderCore",
            dependencies: [
                "ExpansionsMacros",
                "Swallow",
            ],
            path: "Sources/MacroBuilderCore"
        ),
        .target(
            name: "SwiftSyntaxUtilities",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftOperators", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
                .product(name: "SwiftParserDiagnostics", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                "Swallow",
            ],
            path: "Sources/SwiftSyntaxUtilities"
        ),
    ]
)
