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
    @State private var currency: Currency? = Currency.GBP
    @State private var amount: Double = 0
    @State private var selectedCategory: Category?
    @State private var selectedSubcategory: Subcategory?
    @State private var description: String = ""
    @State private var createdTime: Date = Date()
    @State private var newTime: Date = Date()
    @State private var showDatePicker: Bool = false
    @State private var showSubcategoryPicker: Bool = false
    
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
                AmountText(amount: $amount, currency: self.currency!)
                Divider()
                CategoryList<CategoryItem>(categories: self.accountData.categories) { category in
                    CategoryItem(category: category, selectedCategory: self.$selectedCategory) {
                        if (self.selectedCategory?.subcategories.count)! > 0 {
                            self.showSubcategoryPicker.toggle()
                        }
                    }
                }
                .padding()
                .actionSheet(isPresented: $showSubcategoryPicker) {
                    ActionSheet(
                        title: Text("title"),
                        message: Text("Message"),
                        buttons: self.getSubtegoryPickerButtons()
                    )
                }
                
                Divider()
                
                
            
                DescriptionText(description: $description, date: self.$createdTime){
                    withAnimation {
                        self.newTime = self.createdTime
                        self.showDatePicker.toggle()
                    }
                }
                .padding(.vertical)
                Divider()
                
                if showDatePicker {
                    GeometryReader { geometry in
                        VStack {
                            DatePicker("", selection:  self.$newTime, in: ...Date(), displayedComponents: [.hourAndMinute, .date])
                                .labelsHidden()
                                .frame(width: geometry.size.width)
                            Button(action: {
                                self.createdTime = self.newTime
                                self.showDatePicker.toggle()
                            }, label: {
                                Text("Sav Date")
                            })
                        }
                    }
                } else { // hide the Add button when editing Date
                    Spacer()
                    Button(action: {
                        print("submit")
                        self.addAccount()
                        self.isVisible = false
                    }, label: {
                        Text("Add Account")
                    })
                }
            }
            .padding()
        }
    }
    
    private func getSubtegoryPickerButtons() -> [ActionSheet.Button] {
        var buttons = self.selectedCategory!.subcategories.map { subtegory in
            Alert.Button.default(Text("\(subtegory.name)")) {
                self.selectedSubcategory = subtegory
                self.showSubcategoryPicker.toggle()
            }
        }
        buttons.append(Alert.Button.cancel())
        return buttons
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
