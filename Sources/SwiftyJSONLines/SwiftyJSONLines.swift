// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct JSONLines {
    public let lines: [String]

    private let dataLines: [Data]

    /// Decodes an array of objects from JSON lines using the provided `JSONDecoder`.
    ///
    /// - Parameters:
    ///   - decoder: A `JSONDecoder` instance to use for decoding the objects. The default value is `JSONDecoder()`.
    /// - Returns: An array of decoded objects of type `T`.
    /// - Throws: An error if the decoding process fails.
    ///
    /// Example usage:
    /// ```swift
    /// let objects: [MyObject] = try getObjects()
    /// ```
    public func toObjects<T: Codable>(with decoder: JSONDecoder = JSONDecoder()) throws -> [T] {
        try dataLines.map { try decoder.decode(T.self, from: $0) }
    }

    /// Parses  JSON lines into an array of dictionaries, where each dictionary represents a JSON object.
    ///
    /// - Returns: An array of dictionaries `[String: Any]` if the parsing is successful, otherwise `nil`.
    /// - Throws: An error if the JSON deserialization fails.
    ///
    /// Example usage:
    /// ```swift
    /// let dictionaries = try getDictionaries()
    /// ```
    public func toDictionaries() throws -> [[String: Any]]? {
        try dataLines.compactMap { try JSONSerialization.jsonObject(with: $0) as? [String: Any] }
    }

    /// Initializes an instance by decoding the given `Data` object into a `String` and
    /// then initializing with the resulting string and encoding.
    ///
    /// - Parameters:
    ///   - data: The `Data` object that contains the raw bytes to be decoded.
    ///   - encoding: The `String.Encoding` used to decode the `Data` into a `String`.
    ///     The default value is `.utf8`.
    ///
    /// - Throws: An error if the initialization of the instance with the decoded string fails.
    ///
    /// - Note: The initializer will cause a fatal error if the `data` cannot be decoded
    ///   into a valid `String` using the provided encoding.
    public init(data: Data, encoding: String.Encoding = .utf8) throws {
        guard let contents = String(data: data, encoding: encoding) else {
            fatalError()
        }

        try self.init(contents, encoding: encoding)
    }

    /// Initializes an instance by separating the given `String` into lines and
    /// then initializing with the resulting string and encoding.
    ///
    /// - Parameters:
    ///   - _ contents: The `String` object that contains lines to be decoded.
    ///   - encoding: The `String.Encoding` used to decode the `Data` into a `String`.
    ///     The default value is `.utf8`.
    ///
    /// - Throws: An error if any line cannot be encoded into `Data`
    /// or if the conversion of a line to a JSON object fails.
    public init(_ contents: String, encoding: String.Encoding = .utf8) throws {
        self.lines = contents.split(separator: "\n").map { String($0) }
        self.dataLines = lines.compactMap { $0.data(using: encoding) }
    }

    /// Initializes an instance by separating the `String` of given path into lines and
    /// then initializing with the resulting string and encoding.
    ///
    /// - Parameters:
    ///   - contentsOfFile: The path to the file that contains lines to be decoded.
    ///   - encoding: The `String.Encoding` used to decode the `Data` into a `String`.
    ///     The default value is `.utf8`.
    ///
    /// - Throws: An error if the file cannot be read or if the contents cannot be processed as JSON objects.
    public init(contentsOfFile path: String, encoding: String.Encoding = .utf8) throws {
        let contents = try String(contentsOfFile: path, encoding: encoding)
        try self.init(contents, encoding: encoding)
    }

    /// Initializes an instance by fetching the contents from a URL asynchronously and
    /// then processing the fetched data to create JSON objects.
    ///
    /// - Parameters:
    ///   - url: The URL from which to fetch the data.
    ///   - encoding: The `String.Encoding` used to decode the fetched data into a `String`.
    ///     The default value is `.utf8`.
    ///
    /// - Throws: An error if the data cannot be fetched from the URL, if the response is invalid,
    ///   or if the data cannot be decoded into a string using the specified encoding.
    /// 
    public init(contentsOf url: URL, encoding: String.Encoding = .utf8) async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let contents = String(data: data, encoding: encoding) else {
            throw URLError(.cannotDecodeContentData)
        }

        try self.init(contents, encoding: encoding)
    }
}
