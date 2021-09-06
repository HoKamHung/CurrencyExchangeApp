//
//  WatchCurrencyListView.swift
//  CurrencyExchangeWatchApp Extension
//
//  Created by Kam Hung Ho on 7/9/2021.
//

import SwiftUI

struct WatchCurrencyListView: View {
    @ObservedObject var viewModel: MainContentViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var contentView: ContentView

    var body: some View {
        List {
            ForEach(viewModel.currencyListObject.currencies.sorted(by: <), id: \.key) { key, value in
                Button {
                    viewModel.to = key
                    contentView.toButtonTitle = String(format: "%@(%@)", value, key)
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text(value)
                }
            }
        }
        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
        .navigationBarTitle("Currencies")
    }
}

struct WatchCurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        let vm:MainContentViewModel = .init()
        WatchCurrencyListView(viewModel: vm, contentView: .init(viewModel: vm, inputValue: "0", toButtonTitle: "Select Currency", toAmount: "0"))
    }
}
