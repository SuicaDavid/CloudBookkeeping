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
        CategoryList(categories: accountData.categories) { category in
            CategoryItem(category: category, selectedCategory: self.$selectedCategory) {
                print(self.selectedCategory?.name as Any)
            }
        }
    }
}

struct CategorySetting_Previews: PreviewProvider {
    static var previews: some View {
        CategorySetting()
            .environmentObject(AccountData())
    }
}
