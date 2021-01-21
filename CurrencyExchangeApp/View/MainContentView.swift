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

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("USD")
                    .padding(.leading)
                    Spacer()
                    TextField("Amount", text: $inputValue)
                        .keyboardType(.numberPad)
                        .onChange(of: inputValue, perform: { value in
                            do {
                                try viewModel.calculate(amount: Double(inputValue)!)
                            } catch {
                                viewModel.calculate(amount: 0)
                            }
                        })
                        .padding(.trailing)
                }
                HStack {
                    Menu {
                        ForEach(viewModel.currencyListObject.currencies.sorted(by: <), id: \.key) { key, value in
                            Button {
                                viewModel.to = key
                            } label: {
                                Text(value)
                            }
                        }
                    } label: {
                        Text(viewModel.to ?? "Output Currency")
                    }
                    .padding(.leading)
                    Spacer()
                    Text(String(viewModel.total))
                        .padding(.trailing)
                }
                Text(viewModel.errorMessage)
                List() {
                    ForEach(viewModel.liveRateObject.quotes.sorted(by: <), id:\.key) {
                        key, value in
                        CurrencyListView(currencyType: key, currencyValue: Double(value))
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
        MainContentView(viewModel: .init(), inputValue: "")
    }
}
