//
//  AmountText.swift
//  CloudBookKeeping
//
//  Created by Suica on 28/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct AmountText: View {
    @Binding var amount: Double
    @State var currency: Currency
    var body: some View {
        HStack {
            Text("Amount")
                .font(.largeTitle)
                .bold()
            Spacer()
            AmountTextField(amount: $amount, currency: self.currency)
        }
    }
}
struct AmountTextField: View {
    @Binding var amount: Double
    @State var currency: Currency
    var body: some View {
        TextField("input the amount of account",
                  value: $amount,
                  formatter: formatterOfAmount,
                  onEditingChanged: { changed in
                    print("amount changed: \(changed)")
        },
                  onCommit: {
                    print("amount commit")
        })
            .font(.title)
            .multilineTextAlignment(.trailing)
    }
    private var formatterOfAmount: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currency.getCurrencyUnit()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
}


struct AmountText_Previews: PreviewProvider {
    static var previews: some View {
        AmountText(amount: .constant(10), currency: .CNY)
    }
}
