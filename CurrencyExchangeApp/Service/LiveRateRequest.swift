//
//  LiveRateRequest.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 11/1/2021.
//

import Foundation

struct LiveRateRequest : APIRequestType
{
    typealias Response = LiveRateResponse

    var source: String?

    var path: String { return "/live" }
    var queryItems: [URLQueryItem]? {
        if source != nil {
            return [
                .init(name: "access_key", value: "83a5386224c547dea48dc10206605744"),
                .init(name: "source", value: source!),
                .init(name: "format", value: "1")
            ]
        }
        else {
            return [
                .init(name: "access_key", value: "83a5386224c547dea48dc10206605744"),
                .init(name: "format", value: "1")
            ]
        }
    }
}
