//
//  CategoryList.swift
//  CloudBookkeeping
//
//  Created by Suica on 10/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct CategoryList<ItemView>: View where ItemView: View {
    var categories: [Category]
    private var viewFormItem: (Category) -> ItemView
    private let itemWidth = 50
    
    init(categories: [Category], viewFormItem: @escaping (Category) -> ItemView) {
        self.categories = categories
        self.viewFormItem = viewFormItem
    }
    
    var body: some View {
        GeometryReader {
            geometry in self.bodyView(geometry: geometry)
        }
    }
    
    func bodyView(geometry: GeometryProxy) -> some View {
        let count = categories.count
        let colNumber = self.getColNumber(geometry: geometry)
        let rowNumber = count / colNumber + 1
        return VStack(alignment: .leading, spacing: 10) {
            ForEach(0..<rowNumber, id: \.self) { row in
                HStack(alignment: .center) {
                    ForEach(0..<min(colNumber, (count - colNumber * row)), id: \.self) { col in
                        self.viewFormItem(self.categories[self.getIndexFromList(row: row, col: col, colNumber: colNumber)])
                    }
                }
            }
        }
    }
    
    func getIndexFromList(row: Int, col: Int, colNumber: Int) -> Int {
        return col + row * colNumber
    }
    
    func getColNumber(geometry: GeometryProxy) -> Int {
        let listWidth = geometry.size.width
        return Int(listWidth) / itemWidth
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList<CategoryItem>(categories: AccountData().categories) { category in
            CategoryItem(category: category)
        }
    }
}
