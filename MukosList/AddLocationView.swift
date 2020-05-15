//
//  AddLocationView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct AddLocationView: View {
    @Environment(\.presentationMode) var presentation
    
    @State var locationName = ""
    @Binding var isShowingNewLocationFlow: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }.padding(.leading, 28)
                    Spacer()
                }.padding(.top, 28)
                Spacer()
                Text("Give your list a name")
                    .font(.headline)
                    .foregroundColor(Color("medium_gray"))
                    .padding(.bottom, 12.0)
                HStack {
                    TextField("Trader Joe's...", text: $locationName)
                    .frame(height: 56.0)
                    .border(Color("light_gray"))
                }.padding(.horizontal, 16)
                NavigationLink(destination: AddItemView(isShowingNewLocationFlow: self.$isShowingNewLocationFlow, locationName: locationName, itemName: "Bananas"), label:
                 {
                    Text("Done")
                })
                Spacer()
            }.navigationBarHidden(true).navigationBarTitle(Text("hiding!"))
        }
    }
}


struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView(isShowingNewLocationFlow: .constant(true))
    }
}
