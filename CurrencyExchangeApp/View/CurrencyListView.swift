//
//  CurrencyListView.swift
//  CurrencyExchangeApp
//
//  Created by Kam Hung Ho on 12/1/2021.
//

import SwiftUI

struct CurrencyListView: View {
    public var currencyType : String
    public var currencyValue : Double

    var body: some View {
        HStack {
            Text(currencyType).padding()
            Spacer()
            Text(String(currencyValue)).padding(.trailing)
        }
    }
}

struct CurrencyListView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyListView(currencyType: "USDJPY", currencyValue: 100)
    }
}
