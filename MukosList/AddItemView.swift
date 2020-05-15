//
//  AddItemView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentation
    
    @Binding var isShowingNewLocationFlow: Bool
    @State var locationName: String
    @State var itemName: String
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Edit")
                        .foregroundColor(Color("medium_gray"))
                }.padding(.leading, 28)
                Spacer()
                Text("Trader Joe's")
                    .font(.title)
                    .foregroundColor(Color("medium_gray"))
                Spacer()
                Button(action: {
                   self.isShowingNewLocationFlow.toggle()
                }) {
                    Image(systemName: "xmark")
                }.padding(.trailing, 28)
            }.padding(.bottom, 28).padding(.top, 18)
            Spacer()
            HStack {
                Spacer().frame(width:24)
                TextField("Cabbage, Cake, etc.", text: $itemName)
                .frame(height: 56.0)
                .border(Color("orange"))
                Spacer().frame(width:24)
            }
            Spacer()
            HStack(alignment: .top) {
                Button(action: {
                    //idk yet
                }) {
                    Image("filter")
                }.padding(.leading, 16).padding(.top, 14)
                List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                    ItemCell()
                }.padding(.leading, -12)
            }
        }
        .navigationBarHidden(true).navigationBarTitle(Text("hiding!"))
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
                Text("Bananas")
                    .font(.headline)
                    .foregroundColor(Color("text_grey"))
                Text("Submitted 9:42")
                    .font(.footnote)
                    .foregroundColor(Color("text_grey"))
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
