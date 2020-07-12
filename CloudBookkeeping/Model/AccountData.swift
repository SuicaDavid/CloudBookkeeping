//
//  AccountData.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

class AccountData: ObservableObject {
    @Published var accounts: Array<Account> = []
    @Published var categories: [Category] = []
    @Published var selectedCurrency: Currency = .GBP
    @Published var selectedAccountType: AccountType = .expense
    init() {
        addCategory(name: "Food", image: "🍟")
        addCategory(name: "Dring", image: "🥤")
        addCategory(name: "Other", image: "123")
        edditCategory(name: "Other", image: "📃")
        for index in 1...50 {
            addCategory(name: "Test\(index)", image: "🔧")
        }
        addSubcategory(categoryName: "Food", subcategoryName: "Eat In")
        addSubcategory(categoryName: "Food", subcategoryName: "Take")
        edditSubcategory(categoryName: "Food", subcategoryName: "Take", newSubcategoryName: "Take away")
        
        //        addAccount(
        //            amount: 10,
        //            category: categories["Food"] ?? Category(name: "Food", image: "🍟"),
        //            subcategory: categories["Food"]?.subcategorys["Delivery"] ??  Subcategory(name: "Delivery"),
        //            description: "KFC"
        //        )
        //        addAccount(
        //            amount: 24,
        //            category: categories["Drink"] ?? Category(name: "Drink", image: "🥤"),
        //            subcategory: categories["Drink"]?.subcategorys["Coffee"] ??  Subcategory(name: "Coffee"),
        //            description: "Starbucks"
        //        )
    }
    
    func addCategory(name: String, image: String) {
        if !categories.contains(where: { $0.name == name}) {
            categories.append(Category(name: name, image: image))
        }
    }
    
    func edditCategory(name: String, image: String) {
        if let index = categories.firstIndex(where: { $0.name == name }) {
            categories[index] = Category(name: name, image: image)
        }
    }
    
    func addSubcategory(categoryName: String, subcategoryName: String) {
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            if !categories[categoryIndex].subcategories.contains(where: { $0.name == subcategoryName }) {
                categories[categoryIndex].subcategories.append(Subcategory(name: subcategoryName))
            }
        }
    }
    
    func edditSubcategory(categoryName: String, subcategoryName: String, newSubcategoryName: String) {
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            if let subcategoryIndex = categories[categoryIndex].subcategories.firstIndex(where: { $0.name == subcategoryName }) {
                categories[categoryIndex].subcategories[subcategoryIndex] = Subcategory(name: newSubcategoryName)
            }
        }
    }
    
    func addAccount(amount: Double, category: Category, subcategory: Subcategory, description: String) {
        let account = Account(
            amount: amount,
            accountType: self.selectedAccountType,
            currency: self.selectedCurrency,
            category: category, subcategory: subcategory,
            description: description,
            createdTime: Date(),
            finalEdditTime: Date())
        accounts.append(account)
    }
    
    //    func edditAccount(oldAccount: Account) {
    //        let account = Account(amount: oldAccount.amount, currency: oldAccount.currency, category: oldAccount.category, subcategory: oldAccount.subcategory, description: oldAccount.description, createdTime: oldAccount.createdTime, finalEdditTime: Date())
    //        accounts.formIndex(<#T##i: &Int##Int#>, offsetBy: <#T##Int#>)
    //    }
}
