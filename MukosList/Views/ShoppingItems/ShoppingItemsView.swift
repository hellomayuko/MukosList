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
            NSSortDescriptor(keyPath: \ShoppingItem.lastUpdated, ascending: true),
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
//                if(self.isPresentedFromAddListView) {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("Edit").foregroundColor(Color("medium_gray"))
                    }.padding(.leading, 28)
//                }
                Spacer()
                Text(self.listName)
                    .font(.title)
                    .foregroundColor(Color("medium_gray"))
                Spacer()
                Button(action: {
                   self.isBeingPresented.toggle()
                }) {
                    Image(systemName: "xmark")
                }.padding(.trailing, 28)
            }.padding(.bottom, 28).padding(.top, 18)
            Spacer()
            HStack {
                Spacer().frame(width:24)
                TextField("Cabbage, Cake, etc.", text: $itemName, onEditingChanged: {_ in
                    print("added \(self.itemName)")
                }, onCommit: {
                    self.dataManager.addItem(self.itemName, toList: self.listName, quantity: 1, highPriority: false, context: self.managedObjectContext)
                })
                    .frame(height: 56.0)
                    .border(Color("orange"))
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
                             performDeletion: self.performDelete)
                             {(shoppingItem: ShoppingItem) in
                                ItemCell(shoppingItem: shoppingItem)
                    }.padding()
            }
        }
        .navigationBarHidden(true).navigationBarTitle(Text("hiding!"))
    }
    
    func performDelete(_ objects: Set<ShoppingItem>) {
        self.dataManager.deleteItems(objects, context: self.managedObjectContext)
    }
}

struct ShoppingItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingItemsView(isBeingPresented: .constant(true), isPresentedFromAddListView: .constant(false), listName: "Trader Joe's", itemName: "")
    }
}
