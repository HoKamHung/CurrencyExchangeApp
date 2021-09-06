//
//  CurrencyExchangeAppApp.swift
//  CurrencyExchangeWatchApp Extension
//
//  Created by Kam Hung Ho on 6/9/2021.
//

import SwiftUI

@main
struct CurrencyExchangeAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(viewModel: .init(), inputValue: "0", toButtonTitle: "Select Currency", toAmount: "0")
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
