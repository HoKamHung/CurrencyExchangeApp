//
//  APIController.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 11/1/2021.
//

import Foundation
import Combine

enum APIControllerError: Error {
    case responseError
    case parseError(Error)
}

protocol APIRequestType
{
    associatedtype Response: Decodable

    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
}

// Protocol for APIController
protocol APIConnectionType
{
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIControllerError> where Request: APIRequestType
}

class APIController: APIConnectionType
{
    public var baseURL: URL

    init (baseURL: URL)
    {
        self.baseURL = baseURL;
    }

    // Get the response from API and store the responded data into corresponding object type
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIControllerError> where Request : APIRequestType {
        let pathURL = URL(string: request.path, relativeTo: baseURL)!

        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField:"Content-Type")

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, urlResponse in data }
            .mapError { _ in APIControllerError.responseError }
            .decode(type: Request.Response.self, decoder: decoder)
            .mapError(APIControllerError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
