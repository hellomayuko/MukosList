//
//  NewListButton.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct NewListButton: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var showAddListView: Bool
    
    var body: some View {
        Button(action: {
            self.showAddListView.toggle()
        }) {
            Image("add_gray")
                .padding(.leading, 14.0)
            Text("Create New List")
                .font(.headline)
                .padding(.trailing, 160.0)
                .padding(.leading, 18.0)
                .foregroundColor(Color("medium_gray"))
        }
        .padding(.horizontal, 16.0)
        .frame(height: 72.0)
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 3)
        .sheet(isPresented: self.$showAddListView) {
            AddListView(showAddListView: self.$showAddListView).environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}
