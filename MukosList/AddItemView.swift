//
//  AddItemView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @Binding var isShowingNewLocationFlow: Bool
    @State var locationName: String
    @State var itemName: String
    
    var body: some View {
        VStack {
            TextField("Trader Joe's...", text: $itemName)
            .frame(height: 56.0)
            .border(Color("light_gray"))
            Spacer()
            HStack(alignment: .top) {
                Button(action: {
                    //idk yet
                }) {
                    Image("add_yellow")
                }.padding(.leading, 16).padding(.top, 10)
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    ItemCell()
                }.padding(.leading, -8)
            }
        }
        .navigationBarItems(trailing: Button(action: {
            self.isShowingNewLocationFlow.toggle()
        }) {
            Image(systemName: "xmark")
        })
        .navigationBarTitle(locationName)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isShowingNewLocationFlow: .constant(true), locationName: "Bananas", itemName: "")
    }
}

struct ItemCell: View {
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text("Bananas").font(.headline)
                Text("Submitted 9:42").font(.footnote)
            }
            Spacer()
            Button(action: {
                //edit options
            }) {
                Image("ellipsis")
            }
        }.frame(height: 50.0)
    }
}
