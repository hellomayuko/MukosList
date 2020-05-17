//
//  ListCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ListCell: View {
    @Binding var showingAddItem: Bool
    var list: ShoppingList
    
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
                Text(list.name ?? "N/A")
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
