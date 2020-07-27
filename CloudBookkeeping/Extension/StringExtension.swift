//
//  StringExtension.swift
//  CloudBookKeeping
//
//  Created by Suica on 27/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

extension String {
    func stripFile () -> String {
        var components = self.components(separatedBy: ".")
        guard components.count > 1 else { return self }
        components.removeLast()
        return components.joined(separator: ".")
    }
}
