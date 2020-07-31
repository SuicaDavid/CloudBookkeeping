//
//  AccountList.swift
//  CloudBookkeeping
//
//  Created by Suica on 08/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct AccountList: View {
    @Binding var accounts: [Account]
    @State var onTapItemGesture: (_ account: Account) -> Void
    
    var body: some View {
        VStack {
            Text("\(accounts[0].amount)")
            ForEach(accounts, id: \.self.id ) { account in
                self.accountItem(account: account)
                    .onTapGesture {
                        self.onTapItemGesture(account)
                }
            }
        }
        .font(.body)
    }
    
    func accountItem(account: Account) -> some View {
        return HStack {
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
        AccountList(accounts: .constant(AccountData().accounts)) {_ in
            print("1")
        }
    }
}
