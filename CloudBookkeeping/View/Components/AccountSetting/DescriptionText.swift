//
//  DescriptionText.swift
//  CloudBookKeeping
//
//  Created by Suica on 28/07/2020.
//  Copyright © 2020 Suica. All rights reserved.
//

import SwiftUI

struct DescriptionText: View {
    @Binding var description: String
    @Binding var date: Date
    @State var onTapTitleGesture: (() -> Void)?
    
    var body: some View {
        HStack {
            Text("\(self.date.customDateString)")
                .onTapGesture {
                    if (self.onTapTitleGesture != nil) { self.onTapTitleGesture!() }
            }
            
            DescriptionTextField(description: $description)
        }
    }
}

struct DescriptionTextField: View {
    @Binding var description: String
    var body: some View {
        TextField("Input the description", text: self.$description, onEditingChanged: { changed in
            print("began: \(changed)")
        }, onCommit: {
            print("Commit")
        })
    }
}

struct DescriptionText_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionText(description: .constant("description"), date: .constant(Date()))
    }
}
