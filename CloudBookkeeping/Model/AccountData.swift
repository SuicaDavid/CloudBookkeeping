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
    @Published var categories: [String: Category] = [String: Category]()
    @Published var selectedCurrency: Currency = .GBP
    
    init() {
        addCategory(name: "Food", image: "🍟")
        addCategory(name: "Dring", image: "🥤")
        addCategory(name: "Ohter", image: "📃")
        addAccount(
            amount: 10,
            category: categories["Food"] ?? Category(name: "Food", image: "🍟"),
            subcategory: categories["Food"]?.subcategorys["Delivery"] ??  Subcategory(name: "Delivery"),
            description: "KFC"
        )
        addAccount(
            amount: 24,
            category: categories["Drink"] ?? Category(name: "Drink", image: "🥤"),
            subcategory: categories["Drink"]?.subcategorys["Coffee"] ??  Subcategory(name: "Coffee"),
            description: "Starbucks"
        )
    }
    
    func addCategory(name: String, image: String) {
        categories[name] = Category(name: name, image: image)
    }
    
    func edditCategory(name: String, image: String) {
        categories[name] = Category(name: name, image: image)
    }
    
    func addSubcategory(categoryName: String, subcategoryName: String) {
        if var category = categories[categoryName] {
            category.subcategorys[subcategoryName] = Subcategory(name: subcategoryName)
        }
    }
    
    func edditSubcategory(categoryName: String, subcategoryName: String) {
        if var category = categories[categoryName] {
            category.subcategorys[subcategoryName] = Subcategory(name: subcategoryName)
        }
    }
    
    func addAccount(amount: Double, category: Category, subcategory: Subcategory, description: String) {
        let account = Account(amount: amount, currency: selectedCurrency, category: category, subcategory: subcategory, description: description, createdTime: Date(), finalEdditTime: Date())
        accounts.append(account)
    }
    
//    func edditAccount(oldAccount: Account) {
//        let account = Account(amount: oldAccount.amount, currency: oldAccount.currency, category: oldAccount.category, subcategory: oldAccount.subcategory, description: oldAccount.description, createdTime: oldAccount.createdTime, finalEdditTime: Date())
//        accounts.formIndex(<#T##i: &Int##Int#>, offsetBy: <#T##Int#>)
//    }
}
