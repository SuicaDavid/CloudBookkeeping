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
    var amount: Double = 0
    var accountType: AccountType = .expense
    var currency: Currency = .GBP
    var category: Category
    var subcategory: Subcategory?
    var description: String
    var createdTime: Date
    var finalEdditTime: Date
}
