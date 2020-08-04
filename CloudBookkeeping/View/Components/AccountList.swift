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
    @State var onDeleteItem: (_ offsets: IndexSet) -> Void
    
    var body: some View {
        VStack {
            List {
                ForEach(accounts, id: \.self.id ) { account in
                    self.accountItem(account: account)
                }
                .onDelete(perform: self.removeAccount)
            }
        }
        .font(.body)
    }
    
    func removeAccount(offsets: IndexSet) {
        self.onDeleteItem(offsets)
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
        .onTapGesture {
                self.onTapItemGesture(account)
        }
    }
}


struct AccountList_Previews: PreviewProvider {
    @State static var accounts = AccountData().accounts
    static var previews: some View {
        AccountList(accounts: self.$accounts, onTapItemGesture:  {_ in
            print("1")
            
        }, onDeleteItem: { offsets in
            self.accounts.remove(atOffsets: offsets)
        })
    }
}
