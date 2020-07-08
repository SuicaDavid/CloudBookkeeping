//
//  ContentView.swift
//  CloudBookkeeping
//
//  Created by Suica on 06/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var accountData: AccountData
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection){
            HomePage(accountData: accountData)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Home")
                    }
                }
                .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(accountData: AccountData())
    }
}
