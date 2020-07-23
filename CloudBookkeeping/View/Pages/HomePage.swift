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
    @State var accountData: AccountData
    @State private var showAddAccountSheet: Bool = false
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
                    self.showAddAccountSheet = true
                }, label: {
                    Spacer()
                    Image(systemName: "plus")
                    Text("Add New Account")
                    Spacer()
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
                .sheet(isPresented: self.$showAddAccountSheet) {
                    AddAccount(accountData: self.$accountData, isVisible: self.$showAddAccountSheet)
                }
                Text("\(self.accountData.accounts[1].description)")
                AccountList(accounts: self.accountData.accounts)
                Spacer()
            }
            .padding()
        }
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(accountData: AccountData())
    }
}
