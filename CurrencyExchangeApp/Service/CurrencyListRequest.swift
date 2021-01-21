//
//  ListRequest.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation

struct CurrencyListRequest : APIRequestType
{
    typealias Response = CurrencyListResponse

    var path: String { return "/list" }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "access_key", value: "83a5386224c547dea48dc10206605744"),
        ]
    }
}
