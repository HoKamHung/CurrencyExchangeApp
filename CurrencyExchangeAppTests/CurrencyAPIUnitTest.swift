//
//  CurrencyAPIUnitTest.swift
//  CurrencyExchangeAppTests
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation
import Combine
import XCTest
@testable import CurrencyExchangeApp

class CurrencyAPIUnitTest: XCTestCase {
    private static let baseURL : String = "http://apilayer.net/api"
    private static let livePath : String = "/live"
    private static let currencyListPath : String = "/list"

    func test_LiveAPICalledSucceed()
    {
        let pathURL = URL(string: CurrencyAPIUnitTest.baseURL + CurrencyAPIUnitTest.livePath)!
        let apiController = UnitTestAPIController(baseURL: pathURL)
        apiController.stub(for: LiveRateRequest.self) { _ in
            Result<LiveRateResponse, APIControllerError>.Publisher(
                LiveRateResponse.init(
                    success: true,
                    terms: "https://currencylayer.com/terms",
                    privacy: "https://currencylayer.com/privacy"
                )
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiController: apiController)
        viewModel.apply(.onAppear)
        XCTAssertTrue(!viewModel.liveRateObject.quotes.isEmpty)
    }

    func test_CurrencyListCalledSucceed()
    {
        let pathURL = URL(string: CurrencyAPIUnitTest.baseURL + CurrencyAPIUnitTest.livePath)!
        let apiController = UnitTestAPIController(baseURL: pathURL)
        apiController.stub(for: CurrencyListRequest.self) { _ in
            Result<CurrencyListResponse, APIControllerError>.Publisher(
                CurrencyListResponse.init(
                    success: true,
                    terms: "https://currencylayer.com/terms",
                    privacy: "https://currencylayer.com/privacy"
                )
            ).eraseToAnyPublisher()
        }
        let viewModel = makeViewModel(apiController: apiController)
        viewModel.apply(.onAppear)
        XCTAssertTrue(!viewModel.currencyListObject.currencies.isEmpty)
    }

    private func makeViewModel(
        apiController: APIController = UnitTestAPIController(baseURL: URL(string:CurrencyAPIUnitTest.baseURL)!)
        ) -> MainContentViewModel {
        return MainContentViewModel(
            apiController: apiController
        )
    }
}
