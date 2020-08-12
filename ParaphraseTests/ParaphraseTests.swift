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
            XCTFail()
            return
        }
                
        XCTAssert(quote.author == "Eliot")
    }
}
