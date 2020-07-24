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
    @State var showAddListView: Bool = false
    
    var body: some View {
        Button(action: {
            self.showAddListView.toggle()
        }) {
            HStack {
                Image("add_gray").padding(.leading, 14)
                Text("Create New List")
                    .font(.headline)
                    .padding(.trailing, 160.0)
                    .padding(.leading, 15.0)
                    .foregroundColor(Color("gray_mediumDark"))
                Spacer()
            }
        }
        .frame(height: 72.0)
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 3)
        .sheet(isPresented: self.$showAddListView) {
            AddListView().environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}

struct NewListButton_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return NewListButton().environment(\.managedObjectContext, context)
    }
}
