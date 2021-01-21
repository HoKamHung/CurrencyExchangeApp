//
//  ListResponse.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation

struct CurrencyListResponse: Decodable {
    var success: Bool
    var terms: String
    var privacy: String
    var currencies: Dictionary <String, String>

    init()
    {
        success = false
        terms = ""
        privacy = ""
        currencies = Dictionary()
    }

    init (success:Bool, terms:String, privacy:String, currencies:Dictionary<String, String> = Dictionary())
    {
        self.success = success
        self.terms = terms
        self.privacy = privacy
        self.currencies = currencies
    }
}

