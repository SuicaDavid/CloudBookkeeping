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
    private let itemWidth: CGFloat = 50
    private let itemPadding: CGFloat = 10
    
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
        let colNumber = self.getColNumber(elementWidth: geometry.size.width)
        let rowNumber = count / colNumber + 1
        return VStack(alignment: .leading, spacing: 0) {
            Text("\(geometry.size.width)  \(colNumber)")
            ForEach(0..<rowNumber, id: \.self) { row in
                HStack(alignment: .center, spacing: 0) {
                    ForEach(0..<self.getColNumber(count: count, colNumber: colNumber, row: row), id: \.self) { col in
                        Group {
                            self.viewFormItem(self.categories[self.getIndexFromList(row: row, col: col, colNumber: colNumber)])
                        }
                        .padding(.bottom, self.itemPadding)
                        .padding(.trailing, self.getPadding(count: count, colNumber: colNumber, row: row, col: col))
                    }
                }
            }
        }
    }
    func getColNumber(count: Int, colNumber: Int, row: Int) -> Int {
        return min(colNumber, (count - colNumber * row))
    }
    
    func getPadding(count: Int, colNumber: Int, row: Int, col: Int) -> CGFloat {
        return col != getColNumber(count: count, colNumber: colNumber, row: row) - 1 ? self.itemPadding : 0
    }
    
    func getIndexFromList(row: Int, col: Int, colNumber: Int) -> Int {
        return col + row * colNumber
    }

    func getColNumber(elementWidth: CGFloat) -> Int {
        return (Int(elementWidth) / Int(itemWidth))
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(["iPad Pro (12.9-inch) (3rd generation)", "iPhone XS Max"], id: \.self) { deviceName in
                CategoryList<CategoryItem>(categories: AccountData().categories) { category in
                    CategoryItem(category: category)
                }
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
            }
        }
    }
}
