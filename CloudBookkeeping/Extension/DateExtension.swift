//
//  DateExtension.swift
//  CloudBookkeeping
//
//  Created by Suica on 13/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

extension Date {
    private var customDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd"
        return formatter
    }
    func getCustomDateString() -> String {
        return self.customDateFormat.string(from: self)
    }
}
