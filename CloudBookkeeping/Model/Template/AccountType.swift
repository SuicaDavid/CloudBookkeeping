//
//  AccountType.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import Foundation

enum AccountType: String, Identifiable, CaseIterable {
    case expense
    case income
    
    var description: String {
        rawValue.prefix(1).uppercased() + rawValue.dropFirst()
    }
    var id: AccountType { self }
}

