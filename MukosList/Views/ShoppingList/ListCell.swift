//
//  ListCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ListCell: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var presentAddItemView: Bool
    
    @State private var showingSheet = false
    
    var list: ShoppingList
    let dataManager = ShoppingListDataManager()
    
    var body: some View {
        HStack {
            Image("add_yellow")
            VStack(alignment:.leading){
                Text(list.name ?? "N/A")
                    .font(.headline)
                
                Text("\(list.numUnpurchasedItems()) items")
                    .font(.subheadline)
            }
            .padding(.leading, 15.0)
            Spacer()
            Button(action: {
                self.showingSheet = true
            }) {
                Image("ellipsis").renderingMode(.template).foregroundColor(Color.black)
            }.actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("What do you want to do?"), message:nil, buttons: [
                    .default(Text("Edit")) { print("edit") },
                    .destructive(Text("Delete")) { self.dataManager.deleteList(self.list, context: self.managedObjectContext)
                    },
                    .cancel(Text("Cancel")) { self.showingSheet = false },
                ])
            }
        }
        .frame(height: 60.0)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let list = SwiftUIPreviewHelper.createList(withContext: context, withItems: false)

        return ListCell(presentAddItemView: .constant(true), list: list)
    }
}
