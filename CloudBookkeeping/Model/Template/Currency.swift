//
//  Current.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import Foundation

enum Currency: CaseIterable {
    case GBP
    case USD
    case CNY
}
extension Currency {
    func getDescription() -> String {
        var description = self.getCurrencyUnit() + "   "
        switch self {
        case .GBP:
            description = description + "GBP(Great Britain Pound)"
        case .USD:
            description = description + "USD(United States Dollar)"
        case .CNY:
            description = description + "CNY(Chinese Yuan)"
        }
        return description
    }
    func getCurrencyUnit() -> String {
        switch self {
        case .GBP:
            return "£"
        case .USD:
            return "$"
        case .CNY:
            return "¥"
        }
    }
}
