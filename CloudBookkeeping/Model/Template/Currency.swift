//
//  Current.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import Foundation

enum Currency {
    case GBP
    case USD
    case CNY
}

func getCurrencyUnit(_ currency: Currency) -> String {
    switch currency {
    case .GBP:
        return "£"
    case .USD:
        return "$"
    case .CNY:
        return "¥"
    }
}
