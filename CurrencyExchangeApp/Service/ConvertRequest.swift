//
//  ConvertRequest.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation

struct ConvertRequest : APIRequestType
{
    typealias Response = ConvertResponse

    var from: String
    var to: String
    var amount: Double

    var path: String { return "/convert" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "access_key", value: "83a5386224c547dea48dc10206605744"),
            .init(name: "from", value: from),
            .init(name: "to", value: to),
            .init(name: "amount", value: String(amount)),
            .init(name: "format", value: "1")
        ]
    }
}
