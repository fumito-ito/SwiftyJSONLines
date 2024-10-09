# SwiftyJSONLines

The better way to deal with JSONLines data in Swift.

## Installation

### Swift Package Manager

```swift
let package = Package(
    name: "MyPackage",
    products: [...],
    targets: [
        .target(
            "YouAppModule",
            dependencies: [
                .product(name: "SwiftyJSONLines", package: "SwiftyJSONLines")
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/fumito-ito/SwiftyJSONLines.git", .upToNextMajor(from: "0.0.1"))
    ]
)
```

## Usage

```swift
let jsonlines = try JSONLines(jsonString)
for json in jsonlines.lines {
    print(json) // => [String: Any] object
}
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/)
