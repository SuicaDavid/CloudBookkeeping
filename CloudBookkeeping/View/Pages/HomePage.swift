//
//  HomePage.swift
//  CloudBookkeeping
//
//  Created by Suica on 07/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI
import UIKit

struct HomePage: View {
    @ObservedObject private var accountData: AccountData = AccountData()
    var body: some View {
        GeometryReader { geometry in
            return VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Monthly Disbursement")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("10000")
                        .font(.title)
                        .fontWeight(.medium)
                    HStack {
                        Text("Monthly Income: 0")
                    }
                }
                .padding(.vertical)
                
                Button(action: {
                    print("123")
                }, label: {
                    Image(systemName: "plus")
                    Text("Add New Account")
                })
                    .font(.title)
                    .frame(maxWidth: geometry.size.width)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(50).padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.orange, lineWidth: 5)
                )
                
                AccountList(accounts: self.accountData.accounts)
            }
            .padding()
        }
    }
}

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

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
