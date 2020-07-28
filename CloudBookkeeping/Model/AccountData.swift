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
    @Published var categoryIcons: [String: UIImage]?
    @Published var selectedCurrency: Currency = .GBP
    
    init() {
        initCategoryIcon()
        initCategory()
        initSubcategory()
        
        addAccount(
            amount: 10,
            selectedAccountType: .expense,
            categoryName: "Food",
            subcategoryName: "Delivery",
            description: "KFC",
            createdTime: Date(),
            finalEdditTime: Date()
        )
        addAccount(
            amount: 24,
            selectedAccountType: .expense,
            categoryName: "Drink",
            subcategoryName: "Coffee",
            description: "Starbucks",
            createdTime: Date(),
            finalEdditTime: Date()
        )
    }
    
    func initCategoryIcon() {
        let fileManager = FileManager.default
        let imagePath = Bundle.main.resourcePath!
        let imageNames = try? fileManager.contentsOfDirectory(atPath: imagePath)
        let pattern = ".(png)$"
        let regex = try? NSRegularExpression(pattern: pattern)
        var categoryIcons: [String: UIImage]? = [:]
        for imageName in imageNames! {
            let range = NSRange(location: 0, length: imageName.utf16.count)
            if regex?.firstMatch(in: imageName, range: range) != nil {
                categoryIcons?[imageName.stripFile()] = UIImage(contentsOfFile: imagePath + "/\(imageName)")
            }
        }
        self.categoryIcons = categoryIcons
    }
    
    func initCategory() {
        addCategory(name: "Food", imageName: "Food")
        addCategory(name: "Drink", imageName: "Drink")
        addCategory(name: "Other", imageName: "123")
        edditCategory(name: "Other", imageName: "📃")
        for index in 1...50 {
            addCategory(name: "Test\(index)", imageName: "🔧")
        }
    }
    
    func initSubcategory() {
        addSubcategory(categoryName: "Food", subcategoryName: "Eat In")
        addSubcategory(categoryName: "Food", subcategoryName: "Delivery")
        addSubcategory(categoryName: "Food", subcategoryName: "Take")
        edditSubcategory(categoryName: "Food", subcategoryName: "Take", newSubcategoryName: "Take away")
        addSubcategory(categoryName: "dring", subcategoryName: "Coffee")
    }
    
    func addCategory(name: String, imageName: String) {
        if !categories.contains(where: { $0.name == name}) {
            let image = categoryIcons?[imageName.lowercased()] ?? categoryIcons!["other"]!
            categories.append(Category(name: name, image: image))
        }
    }
    
    func edditCategory(name: String, imageName: String) {
        if let index = categories.firstIndex(where: { $0.name == name }) {
            let image = categoryIcons?[imageName.lowercased()] ?? categoryIcons!["other"]!
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
    
    func addAccount(amount: Double,
                    selectedAccountType: AccountType,
                    categoryName: String,
                    subcategoryName: String?,
                    description: String,
                    createdTime: Date,
                    finalEdditTime: Date) {
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            print(categoryIndex)
            let category: Category = categories[categoryIndex]
            var subcategory: Subcategory? = nil
            if let subcategoryIndex = category.subcategories.firstIndex(where: { $0.name == subcategoryName }) {
                subcategory = category.subcategories[subcategoryIndex]
            }
            let account = Account(
            amount: amount,
            accountType: selectedAccountType,
            currency: self.selectedCurrency,
            category: category,
            subcategory: subcategory,
            description: description,
            createdTime: createdTime,
            finalEdditTime: finalEdditTime)
            accounts.append(account)
        }
    }
    
    //    func edditAccount(oldAccount: Account) {
    //        let account = Account(amount: oldAccount.amount, currency: oldAccount.currency, category: oldAccount.category, subcategory: oldAccount.subcategory, description: oldAccount.description, createdTime: oldAccount.createdTime, finalEdditTime: Date())
    //        accounts.formIndex(<#T##i: &Int##Int#>, offsetBy: <#T##Int#>)
    //    }
}
