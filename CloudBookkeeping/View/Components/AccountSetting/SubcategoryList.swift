//
//  SubcategoryList.swift
//  CloudBookkeeping
//
//  Created by Suica on 18/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct SubcategoryList: View {
    @State var subcategories: [Subcategory]
    @State var selectSubcategory: ((Subcategory) -> Void)?
    var body: some View {
        List {
            ForEach(self.subcategories, id: \.self.id) { subcategory in
                HStack {
                    Spacer()
                    Text("\(subcategory.name)")
                    Spacer()
                }
                .onTapGesture {
                    self.selectSubcategory?(subcategory)
                }
            }
        }
    }
}

struct SubcategoryList_Previews: PreviewProvider {
    static var previews: some View {
        SubcategoryList(subcategories: AccountData().categories[0].subcategories)
    }
}
