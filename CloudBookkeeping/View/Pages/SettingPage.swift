//
//  SettingPage.swift
//  CloudBookKeeping
//
//  Created by Suica on 06/08/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct SettingPage: View {
    @EnvironmentObject var accountData: AccountData
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                VStack {
                    Image(uiImage: (accountData.userProfile?.photo ?? UIImage(systemName: "person"))!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    Text("\(accountData.userProfile?.username ?? "")")
                }
                Spacer()
            }
            .font(.largeTitle)
            
            SettingRow(rowTitle: "Edit Profile")
            SettingRow(rowTitle: "Currency", rowContent: self.accountData.selectedCurrency.getCurrencyUnit())
            SettingRow(rowTitle: "Category Setting")
            SettingRow(rowTitle: "Login Off")
            Spacer()
        }
        .padding()
    }
}

struct SettingRow: View {
    @State var rowTitle: String = ""
    @State var rowContent: String?
    @State var onTapRowGesture: (() -> Void)?
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(self.rowTitle)
                Spacer()
                if self.rowContent != nil {
                    Text(self.rowContent!)
                }
            }
            .padding()
            .font(.headline)
            Divider()
        }
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage()
        .environmentObject(AccountData())
    }
}
