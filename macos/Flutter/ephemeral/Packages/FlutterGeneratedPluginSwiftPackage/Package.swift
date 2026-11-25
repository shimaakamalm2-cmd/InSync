// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
// Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .macOS("12.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "cloud_firestore", path: "../.packages/cloud_firestore-7.2.0"),
        .package(name: "cupertino_native_better", path: "../.packages/cupertino_native_better-2.7.2"),
        .package(name: "device_info_plus", path: "../.packages/device_info_plus-13.3.0"),
        .package(name: "firebase_auth", path: "../.packages/firebase_auth-7.1.0"),
        .package(name: "firebase_core", path: "../.packages/firebase_core-5.2.0"),
        .package(name: "firebase_storage", path: "../.packages/firebase_storage-14.1.0"),
        .package(name: "flutter_email_sender_method_channel", path: "../.packages/flutter_email_sender_method_channel-2.0.1"),
        .package(name: "shared_preferences_foundation", path: "../.packages/shared_preferences_foundation-2.6.1"),
        .package(name: "url_launcher_macos", path: "../.packages/url_launcher_macos-3.2.6"),
        .package(name: "FlutterFramework", path: "../.packages/FlutterFramework")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "cloud-firestore", package: "cloud_firestore"),
                .product(name: "cupertino-native-better", package: "cupertino_native_better"),
                .product(name: "device-info-plus", package: "device_info_plus"),
                .product(name: "firebase-auth", package: "firebase_auth"),
                .product(name: "firebase-core", package: "firebase_core"),
                .product(name: "firebase-storage", package: "firebase_storage"),
                .product(name: "flutter-email-sender-method-channel", package: "flutter_email_sender_method_channel"),
                .product(name: "shared-preferences-foundation", package: "shared_preferences_foundation"),
                .product(name: "url-launcher-macos", package: "url_launcher_macos"),
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ]
        )
    ]
)
