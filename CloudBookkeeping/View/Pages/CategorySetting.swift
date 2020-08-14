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
        ScrollView {
            ForEach(accountData.categories, id: \.self.id) { category in
                VStack {
                    HStack {
                        Text("\(category.name)")
                        Spacer()
                    }
                    VStack {
                        ForEach(category.subcategories, id: \.self.id) { subcategory in
                            HStack {
                                Text(subcategory.name)
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
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
