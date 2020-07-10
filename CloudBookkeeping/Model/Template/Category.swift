//
//  Category.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct Category: Identifiable {
    var id: String { self.name }
    var name: String
    var image: String
    var subcategories: [Subcategory] = [Subcategory]()
}

struct Subcategory {
    var name: String
}
