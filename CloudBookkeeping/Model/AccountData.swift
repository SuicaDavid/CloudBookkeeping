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
            finalEditTime: Date()
        )
        addAccount(
            amount: 24,
            selectedAccountType: .expense,
            categoryName: "Drink",
            subcategoryName: "Coffee",
            description: "Starbucks",
            createdTime: Date(),
            finalEditTime: Date()
        )
        
        addAccount(
            amount: 88,
            selectedAccountType: .expense,
            categoryName: "Food",
            subcategoryName: "Eat In",
            description: "Pizzahut",
            createdTime: Date(),
            finalEditTime: Date()
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
        editCategory(name: "Other", imageName: "📃")
        for index in 1...50 {
            addCategory(name: "Test\(index)", imageName: "🔧")
        }
    }
    
    func initSubcategory() {
        addSubcategory(categoryName: "Food", subcategoryName: "Eat In")
        addSubcategory(categoryName: "Food", subcategoryName: "Delivery")
        addSubcategory(categoryName: "Food", subcategoryName: "Take")
        editSubcategory(categoryName: "Food", subcategoryName: "Take", newSubcategoryName: "Take away")
        addSubcategory(categoryName: "dring", subcategoryName: "Coffee")
    }
    
    func addCategory(name: String, imageName: String) {
        if !categories.contains(where: { $0.name == name}) {
            let image = categoryIcons?[imageName.lowercased()] ?? categoryIcons!["other"]!
            categories.append(Category(name: name, image: image))
        }
    }
    
    func editCategory(name: String, imageName: String) {
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
    
    func editSubcategory(categoryName: String, subcategoryName: String, newSubcategoryName: String) {
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
                    finalEditTime: Date) {
        if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
            print("add has category \(categoryIndex)")
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
            finalEditTime: finalEditTime)
            accounts.append(account)
            print(accounts.count)
        }
    }
    
    func editAccount(id: UUID,
                      amount: Double,
                      selectedAccountType: AccountType,
                      categoryName: String,
                      subcategoryName: String?,
                      description: String,
                      finalEditTime: Date) {
        if let accountIndex = accounts.firstIndex(where: { $0.id == id }) {
            print("edit has id")
            if let categoryIndex = categories.firstIndex(where: { $0.name == categoryName }) {
                print("edit has category")
                let category: Category = categories[categoryIndex]
                var subcategory: Subcategory? = nil
                if let subcategoryIndex = category.subcategories.firstIndex(where: { $0.name == subcategoryName }) {
                    print("edit has subcategory")
                    subcategory = category.subcategories[subcategoryIndex]
                }
                let editedAccount = accounts[accountIndex]
                let newAccount = Account(
                    id: editedAccount.id,
                    amount: amount,
                    accountType: selectedAccountType,
                    currency: self.selectedCurrency,
                    category: categories[categoryIndex],
                    subcategory: subcategory,
                    description: description,
                    createdTime: editedAccount.createdTime,
                    finalEditTime: finalEditTime
                )
                accounts[accountIndex] = newAccount
                print("amount: \(accounts[accountIndex].amount)")
                for account in accounts {
                    print(account.description)
                }
            }
        }
    }
    func deleteAccount(at index: Int) {
//        if let accountIndex = accounts.firstIndex(where: { $0.id == id }) {
//            accounts.remove(at: accountIndex)
//        }
        accounts.remove(at: index)
        print(self.accounts.count)
    }
}
