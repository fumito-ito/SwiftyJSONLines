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
// You can parse and iterate json objects from jsonl format string.
let jsonlines = try JSONLines(jsonString)
for json in jsonlines.toDictionaries() {
    print(json) // => [String: Any] object
}

// Ofcourse, you can get json lines from data,
let jsonlinesFromData = try JSONLines(data: jsonStringData)

// local file...
let jsonlinesFromLocalPath = try JSONLines(contentsOfFile: "/path/to/example.jsonl")

// and remote file
let jsonlinesFromRemoteFile = try await JSONLines(contensOf: URL(string: "https://example.com/path/to/example.jsonl"))
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/)
