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
            
            
            SettingRow(rowTitle: "Edit Profile", rowContent: .constant("")) {
                EmptyView()
            }
            SettingCurrencyRow(rowTitle: "Currency", rowContent: self.$selectedCurrencyString) {
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
            SettingRow(rowTitle: "Category Setting", rowContent: .constant("")) {
                CategorySetting()
            }
            SettingRow(rowTitle: "Login Off", rowContent: .constant("")) {
                EmptyView()
            }
            Spacer()
        }
        .navigationBarTitle("")
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

struct SettingRow<Destination: View>: View {
    @State var rowTitle: String = ""
    @Binding var rowContent: String?
    var destinationView: (() -> Destination) = {EmptyView() as! Destination}
    
    init(rowTitle: String) {
        _rowTitle = State(wrappedValue: rowTitle)
        _rowContent = Binding(.constant(""))
        self.destinationView = {EmptyView() as! Destination}
    }
    
    init(rowTitle: String, rowContent: Binding<String?>) {
        _rowTitle = State(wrappedValue: rowTitle)
        _rowContent = rowContent
        self.destinationView = {EmptyView() as! Destination}
    }
    
    init(rowTitle: String, rowContent: Binding<String?>, @ViewBuilder destinationView: @escaping () -> Destination) {
        _rowTitle = State(wrappedValue: rowTitle)
        _rowContent = rowContent
        self.destinationView = destinationView
    }
    
    var body: some View {
        NavigationLink(destination: self.destinationView()) {
            VStack {
                Divider()
                HStack {
                    Text(self.rowTitle)
                    Spacer()
                    Text(self.rowContent ?? "")
                }
                .padding()
                .font(.headline)
                Divider()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SettingCurrencyRow: View {
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

struct TestView: View {
    var body: some View {
        Text("TestView")
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingPage(accountData: AccountData())
                .environment(\.colorScheme, .dark)
            SettingPage(accountData: AccountData())
        }
    }
}
