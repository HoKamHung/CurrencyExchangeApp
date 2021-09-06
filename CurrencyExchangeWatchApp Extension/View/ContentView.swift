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
        VStack{
            HStack {
                Text(viewModel.errorMessage)
            }
            HStack{
                Text("From:")
                    .padding(.leading)
                Spacer()
                Text("USD")
                    .padding(.trailing)
            }
            HStack {
                TextField("Amount", text: $inputValue)
                    .multilineTextAlignment(.trailing)
                    .onChange(of: inputValue, perform: { value in
                        viewModel.calculate(amount: Double(inputValue) ?? 0)
                        toAmount = String(format:"%.2f", viewModel.to ?? 0)
                    })
            }
            HStack {
                Text("To: ")
                    .padding(.leading)
                Spacer()
                NavigationLink(
                    destination: WatchCurrencyListView(viewModel: viewModel, contentView: self),
                    label: {
                        Text(toButtonTitle)
                    }
                )
            }
            HStack {
                TextField("Amount", text:$toAmount)
                    .disabled(true)
                    .multilineTextAlignment(.trailing)
            }
            .multilineTextAlignment(.trailing)

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
