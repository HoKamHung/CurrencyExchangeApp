//
//  LiveRateResponse.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation

struct LiveRateResponse: Decodable {
    var success: Bool
    var terms: String
    var privacy: String
    var timestamp: Int64
    var source: String
    var quotes: Dictionary<String, Double>

    init()
    {
        success = false
        terms = ""
        privacy = ""
        timestamp = 0
        source = ""
        quotes = Dictionary()
    }

    init(success: Bool, terms: String, privacy: String, timestamp:Int64 = 0, source:String = "", quotes:Dictionary<String, Double> = Dictionary())
    {
        self.success = success
        self.terms = terms
        self.privacy = privacy
        self.timestamp = timestamp
        self.source = source
        self.quotes = quotes
    }
}
