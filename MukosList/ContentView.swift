//
//  ContentView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/3/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showingAddItem = false
    
    var body: some View {
        List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
            LocationCell(showingAddItem: self.$showingAddItem, location: ShoppingLocation(name: "Trader Joe's"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LocationCell: View {
    @Binding var showingAddItem: Bool
    let location: ShoppingLocation
    
    var body: some View {
        HStack {
            Button(action: {
                self.showingAddItem = true
            }) {
                Image("add_yellow")
            }.sheet(isPresented: self.$showingAddItem) {
                Text("hello!")
            }
            VStack {
                Text("Trader Joe's")
                    .font(.headline)
                Text("3 items")
                    .font(.subheadline)
            }
            Button(action: {
                //edit options
            }) {
                Image("ellipsis")
            }
        }.frame(minWidth: 0, idealWidth: .infinity, maxWidth: 0, minHeight: .infinity, idealHeight: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}
