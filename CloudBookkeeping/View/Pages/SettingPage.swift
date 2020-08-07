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
    @State var showSetCurrencyUnitSheet: Bool = false
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
                .onAppear {
                    print(self.showSetCurrencyUnitSheet)
                    print(self.accountData.selectedCurrency)
                }
                Spacer()
            }
            .font(.largeTitle)
            
            SettingRow(rowTitle: "Edit Profile")
            SettingRow(rowTitle: "Currency", rowContent: self.accountData.selectedCurrency.getCurrencyUnit()) {
                self.showSetCurrencyUnitSheet = true
            }
                .actionSheet(isPresented: self.$showSetCurrencyUnitSheet) {
                    ActionSheet(
                        title: Text("Setting Currency"),
                        message: Text("This setting will change the normal currency of account"),
                        buttons: self.getCurrencyPickerButtons()
                    )
                }
            SettingRow(rowTitle: "Category Setting")
            SettingRow(rowTitle: "Login Off")
            Spacer()
        }
        .padding()
    }
    
    private func getCurrencyPickerButtons() -> [ActionSheet.Button] {
        var buttons: [Alert.Button] = []
        Currency.allCases.forEach { currency in
            let button = Alert.Button.default(Text("\(currency.getDescription())")) {
                self.accountData.selectedCurrency = currency
                self.showSetCurrencyUnitSheet = false
            }
            buttons.append(button)
        }
        buttons.append(Alert.Button.cancel())
        return buttons
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
        .contentShape(Rectangle())
        .onTapGesture {
            self.onTapRowGesture?()
        }
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage()
        .environmentObject(AccountData())
    }
}
