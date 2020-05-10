//
//  AddLocationView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct AddLocationView: View {
    @State var locationName = ""
    
    var body: some View {
        VStack {
            Text("Give your list a name")
                .font(.headline)
                .foregroundColor(Color("medium_gray"))
                .padding(.bottom, 12.0)
            HStack {
                TextField("Trader Joe's...", text: $locationName, onEditingChanged: {_ in print("something")}, onCommit: {
                    
                })
                .frame(height: 56.0)
                .border(Color("light_gray"))
                
            }.padding(.horizontal, 16)
        }
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
    }
}
