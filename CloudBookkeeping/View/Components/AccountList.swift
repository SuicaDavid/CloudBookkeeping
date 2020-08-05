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
    @State var onDeleteItem: (_ index: Int) -> Void
    
    var body: some View {
        VStack {
            List {
                ForEach(accounts, id: \.self.id ) { account in
                    Button(action: {
                        self.onTapItemGesture(account)
                    }, label: {
                        self.accountItem(account: account)
                    })
                }
                .onDelete(perform: self.removeAccount)
            }
        }
        .font(.body)
    }
    
    func removeAccount(offsets: IndexSet) {
        print(offsets)
        for i in offsets {
            print("ttt \(i)")
            if let index = accounts.firstIndex(where: { $0.id == accounts[i].id }) {
                self.onDeleteItem(index)
            }
        }
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
    @State static var accounts = AccountData().accounts
    static var previews: some View {
        AccountList(accounts: self.$accounts, onTapItemGesture:  {_ in
            print("1")
            
        }, onDeleteItem: { index in
            self.accounts.remove(at: index)
        })
    }
}
