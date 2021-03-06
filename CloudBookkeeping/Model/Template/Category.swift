//
//  Category.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct Category: Identifiable, Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var name: String
    var image: UIImage
    var subcategories: [Subcategory] = [Subcategory]()
}

struct Subcategory: Identifiable, Equatable {
    static func == (lhs: Subcategory, rhs: Subcategory) -> Bool {
        lhs.id == rhs.id
    }
    var id: UUID = UUID()
    var name: String
}
