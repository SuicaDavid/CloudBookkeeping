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
    @Binding var selectedCategory: Category?
    var isSelected: Bool { category == selectedCategory }
    
    var body: some View {
        VStack {
            Text("\(category.image)")
            Text("\(category.name)")
        }
        .foregroundColor(getForegroundColor())
        .frame(width: getDynamicSize(), height: getDynamicSize())
        .background(getBackgroundColor())
        .cornerRadius(5)
        .onTapGesture {
            self.selectedCategory = self.category
        }
    }
    func getForegroundColor() -> Color {
        return isSelected ? .white : .black
    }
    func getBackgroundColor() -> Color {
        return isSelected ? Color.orange: .gray
    }
    
    func getDynamicSize() -> CGFloat {
//        return isSelected ? 50 : 50
        return 50
    }
}

struct CategoryItem_Previews: PreviewProvider {
    @State static var category = Category(name: "Food", image: "🍔")
    @State static var selectedCategory: Category?
    static var previews: some View {
        CategoryItem(category: CategoryItem_Previews.category, selectedCategory:
            CategoryItem_Previews.$selectedCategory) 
    }
}
