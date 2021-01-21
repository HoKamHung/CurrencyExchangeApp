//
//  UnitTestAPIController.swift
//  CurrencyExchangeAppTests
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation
import Combine
@testable import CurrencyExchangeApp

final class UnitTestAPIController : APIController
{
    var stubs: [Any] = []

    func stub<Request>(for type: Request.Type, response: @escaping ((Request) -> AnyPublisher<Request.Response, APIControllerError>)) where Request: APIRequestType {
        stubs.append(response)
    }

    override func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIControllerError> where Request: APIRequestType {

        let response = stubs.compactMap { stub -> AnyPublisher<Request.Response, APIControllerError>? in
            let stub = stub as? ((Request) -> AnyPublisher<Request.Response, APIControllerError>)
            return stub?(request)
        }.last

        return response ?? Empty<Request.Response, APIControllerError>()
            .eraseToAnyPublisher()
    }
}
