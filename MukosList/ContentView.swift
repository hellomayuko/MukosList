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
    @State var showAddLocation = false
    let greyColor = Color("medium_gray")
    
    var body: some View {
        VStack {
            Button(action: {
                self.showAddLocation.toggle()
            }) {
                Image("add_gray")
                    .padding(.leading, 14.0)
                Text("Create New List")
                    .font(.headline)
                    .padding(.trailing, 160.0)
                    .padding(.leading, 18.0)
                    .foregroundColor(greyColor)
            }
            .padding(.horizontal, 16.0)
            .frame(height: 72.0)
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(radius: 50)
            .sheet(isPresented: self.$showAddLocation) { AddLocationView()
             }
            Spacer()
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                LocationCell(showingAddItem: self.$showingAddItem, location: ShoppingLocation(name: "Trader Joe's"))
            }
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
            VStack(alignment:.leading){
                Text("Trader Joe's")
                    .font(.headline)
                Text("3 items")
                    .font(.subheadline)
            }
            .padding(.leading, 15.0)
            Spacer()
            Button(action: {
                //edit options
            }) {
                Image("ellipsis")
            }
        }
        .frame(height: 60.0)
    }
}
