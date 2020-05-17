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
    
    @Binding var isShowingNewListFlow: Bool
    @State var locationName: String
    @State var itemName: String = ""
    
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
                Text(self.locationName)
                    .font(.title)
                    .foregroundColor(Color("medium_gray"))
                Spacer()
                Button(action: {
                   self.isShowingNewListFlow.toggle()
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
                    //add this to the list
                    let newItem = ShoppingItem(context: self.managedObjectContext)
                    newItem.id = UUID()
                    newItem.lastUpdated = Date()
                    newItem.itemName = self.itemName
                    newItem.quantity = 1
                    newItem.highPriority = false
                    do {
                        try self.managedObjectContext.save()
                        print("Item saved.")
                    } catch {
                        print(error.localizedDescription)
                    }
                })
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
                List(shoppingItems, id: \.self) { shoppingItem in
                    ItemCell(shoppingItem: shoppingItem)
                }
            }
        }
        .navigationBarHidden(true).navigationBarTitle(Text("hiding!"))
    }
}

struct ShoppingItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingItemsView(isShowingNewListFlow: .constant(true), locationName: "Trader Joe's", itemName: "")
    }
}
