//
//  UserDefaultsController.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import Foundation

final class UserDefaultsController {
    private static let userDefaultsKeySuccess = "success"
    private static let userDefaultsKeyTerms = "terms"
    private static let userDefaultsKeyPrivacy = "privacy"
    private static let userDefaultsKeyTimestamp = "timestamp"
    private static let userDefaultsKeySource = "source"
    private static let userDefaultsKeyQuotes = "quotes"

    private init() {}

    // Check if Live currency Rate should be reloaded
    public static func shouldReloadLiveRate() -> Bool {
        // Check timestamp of stored data and current time
        let currentTimestamp = NSDate().timeIntervalSince1970
        let savedTimestamp = UserDefaults.standard.double(forKey: userDefaultsKeyTimestamp)

        return currentTimestamp - savedTimestamp > 1800
    }

    // Save the Live currency rate into UserDefaults
    public static func saveLiveRateToUserDefaults(_ liveRateData: LiveRateResponse)
    {
        UserDefaults.standard.set(liveRateData.success, forKey: userDefaultsKeySuccess)
        UserDefaults.standard.set(liveRateData.terms, forKey: userDefaultsKeyTerms)
        UserDefaults.standard.set(liveRateData.privacy, forKey: userDefaultsKeyPrivacy)
        UserDefaults.standard.set(liveRateData.timestamp, forKey: userDefaultsKeyTimestamp)
        UserDefaults.standard.set(liveRateData.source, forKey: userDefaultsKeySource)
        UserDefaults.standard.set(liveRateData.quotes, forKey: userDefaultsKeyQuotes)
    }

    // Load the live currency rate from UserDefaults
    public static func getSavedLiveRateObject() -> LiveRateResponse
    {
        var liveRateObject = LiveRateResponse()

        liveRateObject.success = UserDefaults.standard.bool(forKey: userDefaultsKeySuccess)
        liveRateObject.terms = UserDefaults.standard.string(forKey: userDefaultsKeyTerms)!
        liveRateObject.privacy = UserDefaults.standard.string(forKey: userDefaultsKeyPrivacy)!
        liveRateObject.timestamp = Int64(UserDefaults.standard.integer(forKey: userDefaultsKeyTimestamp))
        liveRateObject.source = UserDefaults.standard.string(forKey: userDefaultsKeySource)!
        liveRateObject.quotes = UserDefaults.standard.dictionary(forKey: userDefaultsKeyQuotes)! as! Dictionary<String, Double>

        return liveRateObject

    }
}
