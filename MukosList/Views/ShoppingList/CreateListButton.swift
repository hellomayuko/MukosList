//
//  NewListButton.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct CreateListButton: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var showAddListView: Bool = false
    @State var setupState: SetupState = .naming

    var body: some View {
        Button(action: {
            self.showAddListView.toggle()
        }) {
            HStack {
                Image("add_gray").padding(.leading, 14)
                Text("Create New List")
                    .font(.headline)
                    .padding(.trailing, 16.0)
                    .padding(.leading, 16.0)
                    .foregroundColor(Color(.secondaryLabel))
                Spacer()
            }
        }
        .frame(height: 72.0)
        .background(Color(.systemFill))
        .cornerRadius(20)
        .sheet(isPresented: self.$showAddListView) {
            AddListView(setupState: self.$setupState, listName: nil, store: nil, uid: nil).environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
}

struct CreateListButton_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return CreateListButton().environment(\.managedObjectContext, context)
    }
}
