//
//  SettingPage.swift
//  CloudBookKeeping
//
//  Created by Suica on 06/08/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct SettingPage: View {
    @ObservedObject var accountData: AccountData
    @State var selectedCurrencyString: String = ""
    @State var showSetCurrencyUnitSheet: Bool = false
    var body: some View {
        return bodyView()
            .onAppear {
                self.selectedCurrencyString = self.accountData.selectedCurrency.getCurrencyUnit()
        }
    }
    func bodyView() -> some View {
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
            
            
            SettingRow(rowTitle: "Edit Profile", rowContent: .constant(""))
            SettingRow(rowTitle: "Currency", rowContent: self.$selectedCurrencyString) {
                self.showSetCurrencyUnitSheet = true
            }
            .sheet(isPresented: self.$showSetCurrencyUnitSheet) {
                List {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Button(currency.getDescription()) {
                            self.accountData.setCurrency(newCurrency: currency)
                            self.selectedCurrencyString = currency.getCurrencyUnit()
                            print(self.accountData.selectedCurrency)
                            self.showSetCurrencyUnitSheet.toggle()
                        }
                    }
                }
            }
            SettingRow(rowTitle: "Category Setting", rowContent: .constant(""))
            SettingRow(rowTitle: "Login Off", rowContent: .constant(""))
            Spacer()
        }
        .padding()
    }

    private func getCurrencyPickerButtons() -> [ActionSheet.Button] {
        var buttons = Currency.allCases.map { currency in
            Alert.Button.default(Text("\(currency.getDescription())")) {
                self.accountData.setCurrency(newCurrency: currency)
                print(self.accountData.selectedCurrency)
                self.showSetCurrencyUnitSheet.toggle()
            }
        }
        buttons.append(Alert.Button.cancel())
        return buttons
    }
}

struct SettingRow: View {
    @State var rowTitle: String = ""
    @Binding var rowContent: String
    @State var onTapRowGesture: (() -> Void)?

    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(self.rowTitle)
                Spacer()
                Text(self.rowContent)
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
        SettingPage(accountData: AccountData())
    }
}
