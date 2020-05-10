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
    @Binding var isShowingNewLocationFlow: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Give your list a name")
                    .font(.headline)
                    .foregroundColor(Color("medium_gray"))
                    .padding(.bottom, 12.0)
                HStack {
                    TextField("Trader Joe's...", text: $locationName)
                    .frame(height: 56.0)
                    .border(Color("light_gray"))
                }.padding(.horizontal, 16)
                NavigationLink(destination: AddItemView(isShowingNewLocationFlow: self.$isShowingNewLocationFlow)) {
                    Text("Done")
                }
            }.navigationBarTitle("New List")
        }
    }
}


struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView(isShowingNewLocationFlow: .constant(true))
    }
}
