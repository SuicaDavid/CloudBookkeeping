//
//  EdditAccount.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct EditAccount: View {
    @EnvironmentObject var accountData: AccountData
    @Binding var isVisible: Bool
    private var editAccount: Account?
    private var isEditing: Bool { editAccount != nil }
    
    @State private var accountType: AccountType = .expense
    @State private var currency: Currency? = Currency.GBP
    @State private var amount: Double = 0
    @State private var selectedCategory: Category?
    @State private var selectedSubcategory: Subcategory?
    @State private var description: String = ""
    @State private var createdTime: Date = Date()
    @State private var finalEditTime: Date = Date()
    @State private var oldTime: Date = Date()
    @State private var newTime: Date = Date()
    @State private var showDatePicker: Bool = false
    @State private var showSubcategoryPicker: Bool = false
    
    init(isVisible: Binding<Bool>, editAccount: Account? = nil) {
        _isVisible = isVisible
        self.editAccount = editAccount
    }
    
    var body: some View {
        return self.bodyView()
            .onAppear {
                if self.isEditing {
                    self.accountType = self.editAccount!.accountType
                    self.amount = self.editAccount!.amount
                    self.selectedCategory = self.editAccount?.category
                    self.selectedSubcategory = self.editAccount?.subcategory
                    self.description = self.editAccount!.description
                    self.createdTime = self.editAccount!.createdTime
                    self.finalEditTime = self.editAccount!.finalEditTime
                    self.oldTime = self.editAccount!.finalEditTime
                    self.newTime = self.editAccount!.finalEditTime
                }
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
                            self.showSubcategoryPicker = true
                        }
                    }
                }
                .padding()
                .actionSheet(isPresented: self.$showSubcategoryPicker) {
                    self.getSubtegoryPicker()
                }
                
                Divider()
                
                
            
                DescriptionText(description: $description, date: self.$oldTime){
                    withAnimation {
                        self.newTime = self.finalEditTime
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
                                self.oldTime = self.newTime
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
                        self.finalEditTime = self.oldTime
                        if self.isEditing {
                            self.eddAccount()
                        } else {
                            self.addAccount()
                        }
                        self.isVisible = false
                    }, label: {
                        self.isEditing ? Text("Edit Account") : Text("Add Account")
                    })
                }
            }
            .padding()
        }
    }
    
    private func getSubtegoryPicker() -> ActionSheet {
        var buttons = self.selectedCategory!.subcategories.map { subcategory in
            return ActionSheet.Button.default(Text("\(subcategory.name)")) {
                self.selectSubcategory(subcategory: subcategory)
            }
        }
        buttons.append(.cancel())
        let actionSheet = ActionSheet(
            title: Text("Subcategory"),
            message: Text("Please select a subcategory for your account"),
            buttons: buttons
        )
        return actionSheet
    }
    
    private func selectSubcategory(subcategory: Subcategory) {
        self.selectedSubcategory = subcategory
        self.showSubcategoryPicker = false
    }
    
    
    
    private func addAccount() {
        if self.amount > 0, self.selectedCategory != nil {
            print("add")
            accountData.addAccount(
                amount: self.amount,
                selectedAccountType: self.accountType,
                categoryName: self.selectedCategory!.name,
                subcategoryName: self.selectedSubcategory?.name ?? nil,
                description: self.description,
                createdTime: self.createdTime,
                finalEditTime: self.finalEditTime
            )
        }
    }
    private func eddAccount() {
        if self.amount > 0, self.selectedCategory != nil {
            print("eddit")
            accountData.editAccount(
                id: self.editAccount!.id,
                amount: self.amount,
                selectedAccountType: self.accountType,
                categoryName: self.selectedCategory!.name,
                subcategoryName: self.selectedSubcategory?.name ?? nil,
                description: self.description,
                finalEditTime: self.finalEditTime
            )
        }
    }
}



struct AddAccount_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPhone XS Max", "iPad Pro (12.9-inch) (3rd generation)"], id: \.self) { deviceName in
                EditAccount(isVisible: .constant(true))
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
                    .environmentObject(AccountData())
            }
        }
        
    }
}
