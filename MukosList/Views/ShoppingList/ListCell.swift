//
//  ListCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

private enum SheetToShow {
    case shoppingList
    case editList
}

struct ListCell: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var presentAddItemView: Bool
    
    @State private var presentSheet = false
    @State private var sheetToPresent: SheetToShow = .shoppingList
    @State private var presentActionSheet = false
    
    var list: ShoppingList
    let dataManager = ShoppingListDataManager()
    
    var body: some View {
        HStack {
            HStack {
                Image("add_yellow")
                VStack(alignment:.leading){
                    Text(list.name ?? "N/A")
                        .font(.headline)
                    
                    Text("\(list.numItemsNotPurchased()) items")
                        .font(.subheadline)
                }
                .padding(.leading, 15.0)
                Spacer().frame(height:20)
            }.contentShape(Rectangle()) //to make the Spacer() tappable
            .onTapGesture {
                self.presentSheet = true
                self.sheetToPresent = .shoppingList
            }
            Spacer()
            Button(action: {
                self.presentSheet = false
                self.presentActionSheet = true
            }) {
                Image("ellipsis").renderingMode(.template).foregroundColor(Color.black)
            }
        }.sheet(isPresented: self.$presentSheet) {
            if(self.sheetToPresent == .shoppingList) {
                ShoppingItemsView(shoppingList: self.list).environment(\.managedObjectContext, self.managedObjectContext)
            } else {
                AddListView(self.list.name, store: self.list.store?.getStore()).environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
        .frame(height: 60.0)
        .actionSheet(isPresented: $presentActionSheet) {
            ActionSheet(title: Text("What do you want to do?"), message:nil, buttons: [
                .default(Text("Edit")) {
                    self.presentActionSheet = false
                    self.presentSheet = true
                    self.sheetToPresent = .editList
                },
                .destructive(Text("Delete")) { self.dataManager.deleteList(self.list, context: self.managedObjectContext)
                },
                .cancel(Text("Cancel")) { self.presentActionSheet = false },
            ])
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let list = SwiftUIPreviewHelper.createList(withContext: context, withItems: false)

        return ListCell(presentAddItemView: .constant(true), list: list)
    }
}
