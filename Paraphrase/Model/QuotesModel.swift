//
//  QuotesModel.swift
//  Paraphrase
//
//  Created by Michael Brünen on 11.08.20.
//  Copyright © 2020 Hacking with Swift. All rights reserved.
//

import Foundation

struct QuotesModel {
    private var quotes = [Quote]()
    
    var count: Int {
        quotes.count
    }
    
    init(testing: Bool = false) {
        
    }
}
