//
//  AccountList.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct AccountList: View {
    var accounts: [Account]
    
    var body: some View {
        VStack {
            ForEach(accounts, id: \.self.id ) { account in
                return HStack {
                    Text(account.category.image)
                    Text("\(account.category.name) - \(account.subcategory.name)")
                    Spacer()
                    // TODO: Localization
                    Text("\(NumberFormatter.localizedString(from: NSNumber(value: account.amount), number: .currency))")
                }
                .padding()
            }
        }
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        AccountList(accounts: AccountData().accounts)
    }
}
