//
//  Account.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import Foundation

struct Account {
    var id: UUID = UUID()
    var amount: Double
    var accountType: AccountType
    var currency: Currency
    var category: Category
    var subcategory: Subcategory
    var description: String
    var createdTime: Date
    var finalEdditTime: Date
}
