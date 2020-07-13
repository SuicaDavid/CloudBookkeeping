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
    @State private var createdTime = Date()
    @State private var showDatePicker: Bool = false
    
    init(accountData: AccountData) {
        _accountData = State(wrappedValue: accountData)
        _accountType = State(wrappedValue: accountData.selectedAccountType)
        _currency = State(wrappedValue: accountData.selectedCurrency)
    }
    
    var body: some View{
        return VStack(alignment: .leading)  {
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
            CategoryList<CategoryItem>(categories: self.accountData.categories) { category in
                CategoryItem(category: category)
            }
            HStack {
                Text("\(createdTime.getCustomDateString())")
                    .onTapGesture {
                        self.showDatePicker.toggle()
                }
                .sheet(isPresented: self.$showDatePicker) {
                    DatePicker("", selection:  self.$createdTime, in: ...Date(), displayedComponents: .date)
                }
                Text("Input the description")
            }
            Spacer()
        }
        .padding()
    }
}

struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPad Pro (12.9-inch) (3rd generation)", "iPhone XS Max"], id: \.self) { deviceName in
                AddAccount(accountData: AccountData())
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
        
    }
}
