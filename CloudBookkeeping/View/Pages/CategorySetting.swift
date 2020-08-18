//
//  CategorySetting.swift
//  CloudBookKeeping
//
//  Created by Suica on 11/08/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct CategorySetting: View {
    @EnvironmentObject var accountData: AccountData
    @State var selectedCategory: Category?
    
    var body: some View {
        List {
            ForEach(accountData.categories, id: \.self.id) { category in
                CategoryRow(category: category) { subcategory in
                    SubcategoryRow(subcategory: subcategory, isLast: self.checkIfLast(list: category.subcategories, item: subcategory))
                }
            }
            .onDelete { indexSet in
                self.accountData.categories.remove(atOffsets: indexSet)
            }
        }
    }
    
    func checkIfLast(list: [Subcategory], item: Subcategory) -> Bool {
        return list.firstIndex(where: { $0.name == item.name }) == (list.count - 1)
    }
}

struct CategoryRow<SubcategoryView>: View where SubcategoryView: View {
    @State var category: Category
    @State var height: CGFloat = 50
    @State var subcategoryView: ((_ subcategory: Subcategory)->SubcategoryView)
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Text("\(self.category.name)")
                    if category.subcategories.count > 0 {
                        Path { path in
                            path.move(to: CGPoint(x: 10, y: 0))
                            path.addLine(to: CGPoint(x: height - 10, y: 0))
                        }
                        .stroke(lineWidth: 1)
                        .frame(width: height, height: 1)
                    } else {
                        EmptyView()
                    }
                }
                Spacer()
            }
            VStack(alignment: .center, spacing: 0) {
                ForEach(self.category.subcategories, id: \.self.id) { subcategory in
                    self.subcategoryView(subcategory)
                }
            }
        }
        .padding()
    }
}

struct SubcategoryRow: View {
    @State var subcategory: Subcategory
    @State var isLast: Bool = false
    @State var height: CGFloat = 50
    @State var arrowOffset: CGFloat = 5
    
    private var halfHeight: CGFloat { self.height / 2 }
     var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Path { path in
                path.move(to: CGPoint(x: halfHeight, y: 0))
                path.addLine(to: CGPoint(x: halfHeight, y: halfHeight))
                path.addLine(to: CGPoint(x: height, y: halfHeight))
                path.addLine(to: CGPoint(x: height - arrowOffset, y: halfHeight - arrowOffset))
                path.move(to: CGPoint(x: height, y: halfHeight))
                path.addLine(to: CGPoint(x: height - arrowOffset, y: halfHeight + arrowOffset))
                if !isLast {
                    path.move(to: CGPoint(x: halfHeight, y: halfHeight))
                    path.addLine(to: CGPoint(x: halfHeight, y: height))
                }
            }
            .stroke(lineWidth: 1)
            .frame(width: height, height: height)
            Text(subcategory.name)
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct CategorySetting_Previews: PreviewProvider {
    static var previews: some View {
        CategorySetting()
            .environmentObject(AccountData())
    }
}
