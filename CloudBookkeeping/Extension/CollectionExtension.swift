//
//  CollectionExtension.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

extension Collection where Element: Identifiable {
    func firstIndex(match element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
    func contains(matching element: Element) -> Bool {
        self.contains(where: { $0.id == element.id })
    }
}
