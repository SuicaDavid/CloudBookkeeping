//
//  CategoryItem.swift
//  CloudBookkeeping
//
//  Created by Suica on 10/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct CategoryItem: View {
    @State var category: Category
    var body: some View {
        VStack {
            Text("\(category.image)")
            Text("\(category.name)")
        }
        .foregroundColor(.white)
        .frame(width:50, height: 50)
        .background(Color.orange)
        .cornerRadius(5)
        
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(category: Category(name: "Food", image: "🍔"))
    }
}
