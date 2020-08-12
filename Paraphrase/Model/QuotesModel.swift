//
//  QuotesModel.swift
//  Paraphrase
//
//  Created by Michael Brünen on 11.08.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation
import GameplayKit

struct QuotesModel {
    private var quotes = [Quote]()
    var randomSource: GKRandomSource?
    
    var count: Int {
        quotes.count
    }
    
    init(testing: Bool = false) {
        if testing {
            randomSource = GKMersenneTwisterRandomSource(seed: 1)
        } else {
            randomSource = GKMersenneTwisterRandomSource()
        }
        
        // load our quote data
        let defaults = UserDefaults.standard
        let quoteData : Data

        // Only try to load saved quotes when not testing
        if !testing, let savedQuotes = defaults.data(forKey: "SavedQuotes") {
            // we have saved quotes; use them
            SwiftyBeaver.info("Loading saved quotes")
            quoteData = savedQuotes
        } else {
            // no saved quotes; load the default initial quotes
            SwiftyBeaver.info("No saved quotes")
            let path = Bundle.main.url(forResource: "initial-quotes", withExtension: "json")!
            quoteData = try! Data(contentsOf: path)
        }

        let decoder = JSONDecoder()
        quotes = try! decoder.decode([Quote].self, from: quoteData)
    }
    
    func quote(at position: Int) -> Quote {
        return quotes[position]
    }
    
    func random() -> Quote? {
        guard !quotes.isEmpty else { return nil }
        
        let randomNumber = randomSource?.nextInt(upperBound: quotes.count) ?? 0
        return quote(at: randomNumber)
    }
    
    mutating func add(_ quote: Quote) {
        quotes.append(quote)
    }
    
    mutating func remove(at index: Int) {
        quotes.remove(at: index)
    }
}
