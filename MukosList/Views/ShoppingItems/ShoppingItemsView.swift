//
//  AddItemView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ShoppingItemsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation
    
    @FetchRequest(
        entity: ShoppingItem.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ShoppingItem.lastUpdated, ascending: false),
        ]
    ) var shoppingItems: FetchedResults<ShoppingItem>
    
    @Binding var isBeingPresented: Bool
    @Binding var isPresentedFromAddListView: Bool
    @State var listName: String
    @State var itemName: String = ""
    
    var dataManager = ShoppingItemDataManager()
    
    var body: some View {
        VStack {
            HStack {
                Text(self.lastUpdatedString()).font(.footnote)
                    .foregroundColor(Color("light_gray")).padding(.leading, 19)
                Spacer()
            }
            HStack {
                Spacer().frame(width:24)
                TextField("Enter items", text: $itemName, onEditingChanged: {_ in
                    print("added \(self.itemName)")
                }, onCommit: {
                    self.dataManager.addItem(self.itemName, toList: self.listName, quantity: 1, highPriority: false, context: self.managedObjectContext)
                    self.itemName = ""
                })
                    .font(.title)
                    .frame(height: 56.0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Spacer().frame(width:24)
            }
            Spacer()
            HStack(alignment: .top) {
                /**
                 V2: Filter Button
                Button(action: {
                    //idk yet
                }) {
                    Image("filter")
                }.padding(.leading, 16).padding(.top, 14)
                */
                FilteredList(filterKey: "shoppingList.name",
                             filterValue: self.listName,
                             performDeletion: self.performDelete,
                             sortDescriptors: [
                                NSSortDescriptor(keyPath: \ShoppingItem.lastUpdated, ascending: false),
                    ])
                { (shoppingItem: ShoppingItem) in
                    ItemCell(shoppingItem: shoppingItem)
                }
            }
        }
        .navigationBarTitle(Text(self.listName))
        .navigationBarItems(trailing:
            Button("Edit") {
                print("Edit tapped!")
            }.foregroundColor(Color("medium_gray"))
        )
    }
    
    func performDelete(_ objects: Set<ShoppingItem>) {
        self.dataManager.deleteItems(objects, context: self.managedObjectContext)
    }
    
    func lastUpdatedString() -> String {
        if let lastUpdatedDate = self.dataManager.fetchUpdatedAtFor(list: self.listName, context: self.managedObjectContext) {
            return "Saved \(lastUpdatedDate.timeStampString)"
        }
        return ""
    }
}

struct ShoppingItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingItemsView(isBeingPresented: .constant(true), isPresentedFromAddListView: .constant(false), listName: "Trader Joe's", itemName: "")
    }
}
