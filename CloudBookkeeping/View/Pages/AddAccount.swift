//
//  AddAccount.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct AddAccount: View {
    @State var accountData: AccountData
    @State private var accountType: AccountType
    @State private var currency: Currency
    @State private var amount: Double = 0
    
    init(accountData: AccountData) {
        _accountData = State(wrappedValue: accountData)
        _accountType = State(wrappedValue: accountData.selectedAccountType)
        _currency = State(wrappedValue: accountData.selectedCurrency)
    }
    
    var body: some View {
        return VStack {
            HStack {
                ForEach(AccountType.allCases) { type in
                    Text("\(type.description)")
                        .font(type == self.accountType ? .headline : .body)
                        .foregroundColor(type == self.accountType ? .red : .none)
                        .onTapGesture {
                            self.accountType = type
                    }
                }
            }
            HStack {
                Text("Amount")
                Spacer()
                Text("\(currency.getCurrencyUnit()) \(self.amount)")
            }
            HStack {
                ForEach(self.accountData.categories, id: \.self.name) { category in
                    HStack {
                        Text("\(category.name) \(category.image)")
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        AddAccount(accountData: AccountData())
    }
}
