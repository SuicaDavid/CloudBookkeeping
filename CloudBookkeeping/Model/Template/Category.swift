//
//  Category.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct Category {
    var name: String
    var image: String
    var subcategorys: [String: Subcategory] = [String: Subcategory]()
}

struct Subcategory {
    var name: String
}
