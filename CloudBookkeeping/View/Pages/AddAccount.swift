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
        VStack {
            HStack {
                Text("Amount")
                Spacer()
                Text("\(getCurrencyUnit(currency)) \(self.amount)")
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
