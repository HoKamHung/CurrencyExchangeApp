//
//  MainContentViewModel.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 11/1/2021.
//

import Foundation
import SwiftUI
import Combine

final class MainContentViewModel: ObservableObject {
    // Constants
    private static let baseURL : String = "http://apilayer.net/api"

    private var cancellableObjects: [AnyCancellable] = []

    private let apiController: APIController;
    private let onPassthroughSubject = PassthroughSubject<Void, Never>()
    private let liveRateRsponseObject = PassthroughSubject<LiveRateResponse, Never>()
    private let errorObject = PassthroughSubject<APIControllerError, Never>()
    private let currencyResponseObject = PassthroughSubject<CurrencyListResponse, Never>()
    private let convertResponseObject = PassthroughSubject<ConvertResponse, Never>()

    @Published private(set) var liveRateObject : LiveRateResponse = LiveRateResponse()
    @Published private(set) var convertObject : ConvertResponse = ConvertResponse()
    @Published private(set) var currencyListObject : CurrencyListResponse = CurrencyListResponse()
    @Published var errorMessage = ""
    @Published private(set) var outputRate = 0;

    public var from :String = "USD"
    public var to:String?
    public var amount:Double?
    public var total:Double = 0

    enum Input {
        case onAppear
    }

    func apply (_ input: Input)
    {
        switch input {
            case .onAppear:
                onPassthroughSubject.send(())
        }
    }

    init(apiController: APIController = APIController(baseURL: URL(string: baseURL)!))
    {
        self.apiController = apiController;

        self.onInput();
        self.onOutput();
    }

    // Create the API streaming request.
    private func onInput()
    {
        if UserDefaultsController.shouldReloadLiveRate() {
            // Input
            let liveRateRequest = LiveRateRequest()
            let liveRateResponsePublisher = onPassthroughSubject
                .flatMap{ [apiController] _ in
                    apiController.response(from: liveRateRequest)
                        .catch{ [weak self] error -> Empty<LiveRateResponse, Never> in
                            self?.errorObject.send(error)
                            return .init()
                        }
                }

            let liveRateResponseStream = liveRateResponsePublisher
                .share()
                .subscribe(liveRateRsponseObject)

            let currencyListRequest = CurrencyListRequest()
            let currencyListResponsePublisher = onPassthroughSubject
                .flatMap{ [apiController] _ in
                    apiController.response(from: currencyListRequest)
                        .catch{ [weak self] error -> Empty<CurrencyListResponse, Never> in
                            self?.errorObject.send(error)
                            return .init()
                        }
                }

            let currencyListResponseStream = currencyListResponsePublisher
                .share()
                .subscribe(currencyResponseObject)

            cancellableObjects += [
                liveRateResponseStream,
                currencyListResponseStream
            ]
        } else {
            liveRateObject = UserDefaultsController.getSavedLiveRateObject()
        }
    }

    // Create the API streaming response.
    private func onOutput()
    {
        let liveRateResponseStream = liveRateRsponseObject
            .map{$0}
            .assign(to: \.liveRateObject, on: self)

        let liveRateErrorStream = errorObject
            .map { error -> String in
                switch error {
                    case .responseError: return "network error"
                    case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)

        let currencyListResponseStream = currencyResponseObject
            .map{$0}
            .assign(to: \.currencyListObject, on: self)

        let currencyListErrorStream = errorObject
            .map { error -> String in
                switch error {
                    case .responseError: return "network error"
                    case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)

        cancellableObjects += [
            liveRateResponseStream,
            liveRateErrorStream,
            currencyListResponseStream,
            currencyListErrorStream
        ]
    }

    // calculate the total value of the currency rate
    public func calculate (amount: Double) {

        self.amount = amount;
        let rate = liveRateObject.quotes[from + to!]

        total = amount * rate!;
    }
}
