//
//  AddAccount.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct AddAccount: View {
    @Binding var accountData: AccountData
    @Binding var isVisible: Bool
    @State private var accountType: AccountType?
    @State private var currency: Currency?
    @State private var amount: Double = 0
    @State private var selectedCategory: Category?
    @State private var selectedSubcategory: Subcategory?
    @State private var description: String = ""
    @State private var createdTime = Date()
    @State private var showDatePicker: Bool = false
    
    init(accountData: Binding<AccountData>, isVisible: Binding<Bool>) {
        _accountData = accountData
        _isVisible = isVisible
    }
    
    var body: some View {
        return self.bodyView()
            .onAppear {
                self.accountType = self.accountData.selectedAccountType
                self.currency = self.accountData.selectedCurrency
                self.selectedCategory = self.accountData.categories[0]
        }
    }
    func bodyView() -> some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .leading) {
                Text("Cancel")
                    .onTapGesture {
                        self.isVisible = false
                }
                HStack(alignment: .center) {
                    Spacer()
                    ForEach(AccountType.allCases) { type in
                        Text("\(type.description)")
                            .font(type == self.accountType ? .headline : .body)
                            .foregroundColor(type == self.accountType ? .red : .black)
                            .onTapGesture {
                                self.accountType = type
                        }
                    }
                    Spacer()
                }
            }
            .foregroundColor(.blue)
            .padding()
            
            Divider()
            VStack {
                HStack {
                    Text("Amount")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    TextField("input the amount of account", value: $amount, formatter: formatterOfAmount)
                    .font(.title)
                        .multilineTextAlignment(.trailing)
                }
                Text("\(amount)")
                Divider()
                CategoryList<CategoryItem>(categories: self.accountData.categories) { category in
                    CategoryItem(category: category, selectedCategory: self.$selectedCategory)
                }
                .padding()
                Divider()
                HStack {
                    Text("\(self.createdTime.getCustomDateString())")
                        .onTapGesture {
                            self.showDatePicker.toggle()
                    }
                    .sheet(isPresented: self.$showDatePicker) {
                        DatePicker("", selection:  self.$createdTime, in: ...Date(), displayedComponents: .date)
                    }
                    TextField("Input the description", text: self.$description, onEditingChanged: { changed in
                        print("began: \(changed)")
                    }, onCommit: {
                        print("Commit")
                    })
                }
                .padding(.vertical)
                Divider()
                Spacer()
                Button(action: {
                    print("submit")
                    self.addAccount()
                    self.isVisible = false
                }, label: {
                    Text("Add Account")
                })
            }
            .padding()
        }
        
    }
    private var formatterOfAmount: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = currency?.getCurrencyUnit()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    func addAccount() {
        print(self.amount)
        if self.amount > 0, self.selectedCategory != nil {
            print("add")
            accountData.addAccount(
                amount: self.amount,
                categoryName: self.selectedCategory!.name,
                subcategoryName: self.selectedSubcategory?.name ?? nil,
                description: self.description
            )
        }
    }
}


struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone XS Max", "iPad Pro (12.9-inch) (3rd generation)"], id: \.self) { deviceName in
                AddAccount(accountData: .constant(AccountData()), isVisible: .constant(true))
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
        
    }
}
