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
//    @Published var categoryIcons: [Image]
    @Published var selectedCurrency: Currency = .GBP
    @Published var selectedAccountType: AccountType = .expense
    
    init() {
        initCategoryIcon()
        addCategory(name: "Food", image: "🍟")
        addCategory(name: "Drink", image: "🥤")
        addCategory(name: "Other", image: "123")
        edditCategory(name: "Other", image: "📃")
        for index in 1...50 {
            addCategory(name: "Test\(index)", image: "🔧")
        }
        addSubcategory(categoryName: "Food", subcategoryName: "Eat In")
        addSubcategory(categoryName: "Food", subcategoryName: "Delivery")
        addSubcategory(categoryName: "Food", subcategoryName: "Take")
        edditSubcategory(categoryName: "Food", subcategoryName: "Take", newSubcategoryName: "Take away")
        addSubcategory(categoryName: "Drink", subcategoryName: "Coffee")
        
        addAccount(
            amount: 10,
            categoryName: "Food",
            subcategoryName: "Delivery",
            description: "KFC"
        )
        addAccount(
            amount: 24,
            categoryName: "Drink",
            subcategoryName: "Coffee",
            description: "Starbucks"
        )
    }
    
    func initCategoryIcon() {
        let fileManager = FileManager.default
        let imagePath = Bundle.main.resourcePath!
        let imageNames = try? fileManager.contentsOfDirectory(atPath: imagePath)
        let pattern = ".(png)$"
        let regex = try? NSRegularExpression(pattern: pattern)
        
        for imageName in imageNames! {
            let range = NSRange(location: 0, length: imageName.utf16.count)
            if regex?.firstMatch(in: imageName, range: range) != nil {
                print("\(imageName) ")
            }
        }
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
    
    func addAccount(amount: Double, categoryName: String, subcategoryName: String?, description: String) {
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            print(categoryIndex)
            let category: Category = categories[categoryIndex]
            var subcategory: Subcategory? = nil
            if let subcategoryIndex = category.subcategories.firstIndex(where: { $0.name == subcategoryName }) {
                subcategory = category.subcategories[subcategoryIndex]
            }
            let account = Account(
            amount: amount,
            accountType: self.selectedAccountType,
            currency: self.selectedCurrency,
            category: category,
            subcategory: subcategory,
            description: description,
            createdTime: Date(),
            finalEdditTime: Date())
            accounts.append(account)
        }
        print("+++")
        for account in accounts {
            print(account.description)
        }
    }
    
    //    func edditAccount(oldAccount: Account) {
    //        let account = Account(amount: oldAccount.amount, currency: oldAccount.currency, category: oldAccount.category, subcategory: oldAccount.subcategory, description: oldAccount.description, createdTime: oldAccount.createdTime, finalEdditTime: Date())
    //        accounts.formIndex(<#T##i: &Int##Int#>, offsetBy: <#T##Int#>)
    //    }
}
