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
    @ObservedObject var accountData: AccountData
    @State private var showAddAccountSheet: Bool = false
    @State private var showEdditAccountSheet: Bool = false
    @State private var selectedAccount: Account? = nil
    private var monthlyAmount: Double {
        get {
            var totalAmount: Double = 0
            accountData.accounts.forEach { account in
                totalAmount = totalAmount + account.amount
            }
            
            return totalAmount
        }
    }
    private var accounts: [Account] {
        get {
            return accountData.accounts
        }
        set {
            accountData.accounts = newValue
        }
    }
    
    var body: some View {
        self.bodyView()
    }
    func bodyView() -> some View {
        return GeometryReader { geometry in
            return VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Monthly Disbursement")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(self.accountData.selectedCurrency.getCurrencyUnit() + String(format: "%.2f", Float(self.monthlyAmount)))
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
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Text("Add New Account")
                        Spacer()
                    }
                    .font(.title)
                    .frame(maxWidth: geometry.size.width)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(50).padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color.orange, lineWidth: 5))
                })
                    .sheet(isPresented: self.$showAddAccountSheet) {
                        EditAccount(isVisible: self.$showAddAccountSheet)
                            .environmentObject(self.accountData)
                }
                AccountList(accounts: self.$accountData.accounts, onTapItemGesture:  { account in
                    self.selectedAccount = account
                    self.showEdditAccountSheet.toggle()
                }, onDeleteItem: { index in
                    self.accountData.deleteAccount(at: index)
                })
                    .sheet(isPresented: self.$showEdditAccountSheet) {
                        EditAccount(isVisible: self.$showEdditAccountSheet, editAccount: self.selectedAccount)
                            .environmentObject(self.accountData)
                }
                Spacer()
            }
            .padding()
        }
    }
}


struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        let accountDate = AccountData()
        return HomePage(accountData: accountDate)
//            .environmentObject(accountDate)
    }
}
