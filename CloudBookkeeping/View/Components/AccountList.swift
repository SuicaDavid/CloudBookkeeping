//
//  AccountList.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct AccountList: View {
    @State var accounts: [Account]
    @State var onTapItemGesture: () -> Void
    
    var body: some View {
        VStack {
            ForEach(accounts, id: \.self.id ) { account in
                AccountItem(account: account)
                    .onTapGesture {
                        self.onTapItemGesture()
                }
            }
        }
        .font(.body)
    }
}

struct AccountItem: View {
    @State var account: Account
    var body: some View {
        HStack {
            Image(uiImage: account.category.image)
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                HStack {
                    Text("\(account.category.name)")
                    if account.subcategory != nil {
                        Text(" - \(account.subcategory!.name)")
                    }
                    Spacer()
                    // TODO: Localization
                    Text("\(NumberFormatter.localizedString(from: NSNumber(value: account.amount), number: .currency))")
                }
                Text(account.description)
            }
            .padding(.vertical)
        }
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        AccountList(accounts: AccountData().accounts) {
            print("1")
        }
    }
}
