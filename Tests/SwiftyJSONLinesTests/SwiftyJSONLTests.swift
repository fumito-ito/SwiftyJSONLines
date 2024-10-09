import Testing
import Foundation
@testable import SwiftyJSONLines

let jsonString = """
{"name": "Gilbert", "wins": [["straight", "7♣"], ["one pair", "10♥"]]}
{"name": "Alexa", "wins": [["two pair", "4♠"], ["two pair", "9♠"]]}
{"name": "May", "wins": []}
{"name": "Deloise", "wins": [["three of a kind", "5♣"]]}
"""

@Test func fromString() throws {
    let jsonlines = try JSONLines(jsonString)

    #expect(jsonlines.lines.count == 4)

    let gilbert = try #require(jsonlines.lines.first)
    #expect(gilbert["name"] as? String == "Gilbert")
    #expect(gilbert["wins"] as? [[String]] == [["straight", "7♣"], ["one pair", "10♥"]])

    let alexa = try #require(jsonlines.lines.dropFirst().first)
    #expect(alexa["name"] as? String == "Alexa")
    #expect(alexa["wins"] as? [[String]] == [["two pair", "4♠"], ["two pair", "9♠"]])

    let may = try #require(jsonlines.lines.dropFirst(2).first)
    #expect(may["name"] as? String == "May")
    #expect(may["wins"] as? [[String]] == [])

    let deloise = try #require(jsonlines.lines.dropFirst(3).first)
    #expect(deloise["name"] as? String == "Deloise")
    #expect(deloise["wins"] as? [[String]] == [["three of a kind", "5♣"]])
}

@Test func fromData() throws {
    let jsonlines = try JSONLines(data: jsonString.data(using: .utf8)!)

    #expect(jsonlines.lines.count == 4)

    let gilbert = try #require(jsonlines.lines.first)
    #expect(gilbert["name"] as? String == "Gilbert")
    #expect(gilbert["wins"] as? [[String]] == [["straight", "7♣"], ["one pair", "10♥"]])

    let alexa = try #require(jsonlines.lines.dropFirst().first)
    #expect(alexa["name"] as? String == "Alexa")
    #expect(alexa["wins"] as? [[String]] == [["two pair", "4♠"], ["two pair", "9♠"]])

    let may = try #require(jsonlines.lines.dropFirst(2).first)
    #expect(may["name"] as? String == "May")
    #expect(may["wins"] as? [[String]] == [])

    let deloise = try #require(jsonlines.lines.dropFirst(3).first)
    #expect(deloise["name"] as? String == "Deloise")
    #expect(deloise["wins"] as? [[String]] == [["three of a kind", "5♣"]])
}
