//
//  ContentView.swift
//  CurrencyExchangeWatchApp Extension
//
//  Created by Kam Hung Ho on 6/9/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MainContentViewModel
    @State public var inputValue: String
    @State public var toButtonTitle: String
    @State public var toAmount:String

    var body: some View {
        ScrollView {
            VStack{
                HStack{
                    Text("From:")
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    Text("USD")
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    TextField("Amount", text: $inputValue)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: inputValue, perform: { value in
                            viewModel.calculate(amount: Double(value) ?? 0)
                            toAmount = String(format:"%.2f", viewModel.total)
                        })
                }
                .padding(.horizontal)
                HStack {
                    Text("To: ")
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    NavigationLink(
                        destination: WatchCurrencyListView(viewModel: viewModel, contentView: self),
                        label: {
                            Text(toButtonTitle)
                        }
                    )
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                HStack {
                    TextField("Amount", text:$toAmount)
                        .disabled(true)
                        .multilineTextAlignment(.trailing)
                }
                .multilineTextAlignment(.trailing)
                .padding(.horizontal)

            }
        }
        .navigationBarTitle("Currency")
        .onAppear(perform: {self.viewModel.apply(.onAppear)})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(), inputValue: "0", toButtonTitle: "Select Currency", toAmount: "0")
    }
}
