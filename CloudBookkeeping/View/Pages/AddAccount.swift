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
    @State private var selectedCategory: Category?
    @State private var description: String = ""
    @State private var createdTime = Date()
    @State private var showDatePicker: Bool = false
    
    init(accountData: AccountData) {
        _accountData = State(wrappedValue: accountData)
        _accountType = State(wrappedValue: accountData.selectedAccountType)
        _currency = State(wrappedValue: accountData.selectedCurrency)
    }
    
    var body: some View{
            VStack(alignment: .leading)  {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.top)
                    HStack {
                        ForEach(AccountType.allCases) { type in
                            Text("\(type.description)")
                                .font(type == self.accountType ? .headline : .body)
                                .foregroundColor(type == self.accountType ? .red : .white)
                                .onTapGesture {
                                    self.accountType = type
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                Divider()
                HStack {
                    Text("Amount")
                    Spacer()
                    Text("\(self.currency.getCurrencyUnit()) \(self.amount)")
                }
                CategoryList<CategoryItem>(categories: self.accountData.categories) { category in
                    CategoryItem(category: category, selectedCategory: self.$selectedCategory)
                }
                HStack {
                    Text("\(self.createdTime.getCustomDateString())")
                        .onTapGesture {
                            self.showDatePicker.toggle()
                    }
                    .sheet(isPresented: self.$showDatePicker) {
                        DatePicker("", selection:  self.$createdTime, in: ...Date(), displayedComponents: .date)
                    }
                    TextField("Input the description", text: self.$description, onEditingChanged: { began in
                        print(began)
                    })
                }
                Spacer()
                Button(action: {
                    print("submit")
                }, label: {
                    Text("Add Account")
                })
            }
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
