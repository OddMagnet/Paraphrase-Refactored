//
//  ParaphraseTests.swift
//  ParaphraseTests
//
//  Created by Michael Brünen on 11.08.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import XCTest
@testable import Paraphrase

class ParaphraseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadingInitialQuotes() {
        let model = QuotesModel(testing: true)
        XCTAssert(model.count == 12)
    }

    func testRandomQuote() {
        let model = QuotesModel(testing: true)

        guard let quote = model.random() else {
            XCTFail("Failed to get a random quote")
            return
        }

        XCTAssert(quote.author == "Eliot")
    }

    func testSingleLineFormatting() {
        let model = QuotesModel(testing: true)
        let quote = model.quote(at: 0)

        let formattedText = quote.text.replacingOccurrences(of: "\n", with: " ")
        let testString = "\(quote.author): \(formattedText)"

        XCTAssert(quote.singleLine == testString)
    }

    func testMultiLineFormatting() {
        let model = QuotesModel(testing: true)
        let quote = model.quote(at: 0)

        let testString = "\"\(quote.text)\"\n   — \(quote.author)"
        XCTAssert(quote.multiLine == testString)
    }

    func testAttributedStringFormatting() {
        let model = QuotesModel(testing: true)
        let quote = model.quote(at: 0)

        var textAttributes = [NSAttributedString.Key: Any]()
        var authorAttributes = [NSAttributedString.Key: Any]()

        if let quoteFont = UIFont(name: "Georgia", size: 24) {
            let fontMetrics = UIFontMetrics(forTextStyle: .headline)
            textAttributes[.font] = fontMetrics.scaledFont(for: quoteFont)
        }

        if let authorFont = UIFont(name: "Georgia-Italic", size: 16) {
            let fontMetrics = UIFontMetrics(forTextStyle: .body)
            authorAttributes[.font] = fontMetrics.scaledFont(for: authorFont)
        }

        let testString = NSMutableAttributedString(string: quote.text, attributes: textAttributes)
        let authorString = NSAttributedString(string: "\n\n\(quote.author)", attributes: authorAttributes)
        testString.append(authorString)

        XCTAssert(quote.attributedString == testString)
    }

    func testAddingQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count

        let newQuote = Quote(author: "Paul Hudson", text: "Programming is an art. Don't spend all your time sharpening your pencil when you should be drawing.")
        model.add(newQuote)

        XCTAssert(model.count == quoteCount + 1)
    }

    func testRemovingQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count

        model.remove(at: 0)
        XCTAssert(model.count == quoteCount - 1)
    }

    func testReplacingQuote() {
        var model = QuotesModel(testing: true)

        let newQuote = Quote(author: "Ted Logan", text: "All we are is dust in the wind, dude.")
        model.replace(index: 0, with: newQuote)

        let testQuote = model.quote(at: 0)
        XCTAssert(testQuote.author == "Ted Logan")
    }

    func testReplacingEmptyQuote() {
        var model = QuotesModel(testing: true)
        let quoteCount = model.count

        let newQuote = Quote(author: "", text: "")
        model.replace(index: 0, with: newQuote)

        XCTAssert(model.count == quoteCount - 1)
    }

}
