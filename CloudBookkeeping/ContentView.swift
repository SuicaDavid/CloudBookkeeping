//
//  ContentView.swift
//  CloudBookkeeping
//
//  Created by Suica on 06/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var accountData: AccountData
    @State private var selection = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection){
                HomePage(accountData: accountData)
                    .navigationBarHidden(true)
                    .navigationBarTitle(Text("Home"))
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                }
                .tag(0)
                SettingPage(accountData: accountData)
                    .navigationBarHidden(true)
                    .navigationBarTitle(Text("User"))
                    .tabItem {
                        VStack {
                            Image(systemName: "person")
                            Text("User")
                        }
                }
                .tag(1)
            }
        }
    }
}
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let accountData = AccountData()
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(self.accountData)
                .environment(\.colorScheme, .dark)
            ContentView()
                .environmentObject(self.accountData)
        }
    }
}
#endif
