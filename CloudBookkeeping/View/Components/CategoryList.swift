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
    private var itemWidth: CGFloat = 50
    private var itemPadding: CGFloat = 10
    private var displayRow: Int = 3
    
    init(categories: [Category], viewFormItem: @escaping (Category) -> ItemView) {
        self.categories = categories
        self.viewFormItem = viewFormItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.bodyView(geometry: geometry)
        }
        .frame(height: (itemWidth + itemPadding) * CGFloat(displayRow))
    }
    
    func bodyView(geometry: GeometryProxy) -> some View {
        let count = categories.count
        let elementWidth = geometry.size.width
        let colNumber = self.getColNumber(elementWidth: elementWidth)
        let rowNumber = count / colNumber + 1
        let calculatedPadding = self.getPadding(elementWidth: elementWidth, colNumber: colNumber)
        return ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<rowNumber, id: \.self) { row in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<self.getDynamicColNumber(count: count, colNumber: colNumber, row: row), id: \.self) { col in
                            Group {
                                self.viewFormItem(self.categories[self.getIndexFromList(row: row, col: col, colNumber: colNumber)])
                            }
                            .padding(.bottom, calculatedPadding)
                            .padding(.trailing, self.getLastPadding(padding: calculatedPadding, count: count, colNumber: colNumber, row: row, col: col))
                        }
                    }
                }
            }
        }
        .frame(height: self.getElementHeight(calculatedPadding: calculatedPadding))
    }
    func getElementHeight(calculatedPadding: CGFloat) -> CGFloat {
        return CGFloat(self.displayRow) * (self.itemWidth + calculatedPadding) - calculatedPadding
    }
    func getPadding(elementWidth: CGFloat, colNumber: Int) -> CGFloat {
        let gap = elementWidth - ((self.itemPadding + self.itemWidth) * CGFloat(colNumber) - self.itemPadding)
        return gap == 0 ? self.itemPadding : self.itemPadding + gap / CGFloat(colNumber)
    }
    
    func getLastPadding(padding: CGFloat, count: Int, colNumber: Int, row: Int, col: Int) -> CGFloat {
        return col != getDynamicColNumber(count: count, colNumber: colNumber, row: row) - 1 ? padding : 0
    }
    
    func getIndexFromList(row: Int, col: Int, colNumber: Int) -> Int {
        return col + row * colNumber
    }
    
    func getColNumber(elementWidth: CGFloat) -> Int {
        let originalColNumber = Int(elementWidth) / Int(itemWidth + itemPadding)
        let gap = elementWidth - ((self.itemPadding + self.itemWidth) * CGFloat(originalColNumber) - self.itemPadding)
        return gap > self.itemWidth ? originalColNumber + 1 : originalColNumber
    }
    
    func getDynamicColNumber(count: Int, colNumber: Int, row: Int) -> Int {
        return min(colNumber, (count - colNumber * row))
    }
}

struct CategoryList_Previews: PreviewProvider {
    @State static var category = Category(name: "Food", image: UIImage(systemName: "person")!)
    @State static var selectedCategory: Category?
    static var previews: some View {
        Group {
            ForEach(["iPad Pro (12.9-inch) (3rd generation)", "iPhone XS Max"], id: \.self) { deviceName in
                CategoryList<CategoryItem>(categories: AccountData().categories) { category in
                    CategoryItem(category: CategoryList_Previews.category, selectedCategory: CategoryList_Previews.$selectedCategory)
                }
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
            }
        }
    }
}
