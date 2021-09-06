//
//  ContentView.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 11/1/2021.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject var viewModel: MainContentViewModel
    @State public var inputValue: String
    @State public var toButtonTitle: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("From: ")
                        .padding(.leading)
                    Spacer()
                    Text("USD")
                        .padding(.trailing)
                    Spacer()
                    TextField("Amount", text: $inputValue)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                        .onChange(of: inputValue, perform: { value in
                            viewModel.calculate(amount: Double(inputValue) ?? 0)
                        })
                        .padding(.trailing)
                }
                HStack {
                    Text("To: ")
                        .padding(.leading)
                    Menu {
                        ForEach(viewModel.currencyListObject.currencies.sorted(by: <), id: \.key) { key, value in
                            Button {
                                viewModel.to = key
                                toButtonTitle = String(format: "%@(%@)", value, key)
                            } label: {
                                Text(value)
                            }
                        }
                    } label: {
                        Text(toButtonTitle)
                    }
                    Spacer()
                    Text(String(String(format: "%.2f", viewModel.total)))
                        .padding(.trailing)
                }
                Text(viewModel.errorMessage)
                Spacer()
                List {
                    Section(header: Text("Currency Rate List")) {
                        ForEach(viewModel.liveRateObject.quotes.sorted(by: <), id:\.key) {
                            key, value in
                            CurrencyListView(currencyType: key, currencyValue: Double(value))
                        }
                    }
                }
            }
            .navigationBarTitle("Current Currency")
        }
        .onAppear(perform: {self.viewModel.apply(.onAppear)})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView(viewModel: .init(), inputValue: "0", toButtonTitle: "Select Currency")
    }
}
