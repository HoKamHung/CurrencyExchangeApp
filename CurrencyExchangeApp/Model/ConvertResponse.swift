//
//  ConvertResponse.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation

struct ConvertResponse: Decodable {
    var success: Bool
    var terms: String
    var privacy: String
    var query: Dictionary<String, String>
    var info: Dictionary<String, String>
    var result: Double

    init()
    {
        success = false
        terms = ""
        privacy = ""
        query = Dictionary()
        info = Dictionary()
        result = 0
    }
}
