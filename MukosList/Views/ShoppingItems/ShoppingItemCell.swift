//
//  ShoppingItemCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var shoppingItem: ShoppingItem
    @State private var isChecked: Bool = false
    
    let dataManager = ShoppingItemDataManager()

    var body: some View {
        HStack {
            Button(action: {
                self.isChecked.toggle()
                if(self.isChecked) {
                    self.dataManager.scheduleForPurchase(item: self.shoppingItem, context: self.managedObjectContext)
                }
            }) {
                isChecked ? Image("checkmark_true") : Image("checkmark_false")
            }.buttonStyle(PlainButtonStyle())
            VStack(alignment:.leading) {
                Text(shoppingItem.itemName ?? "idk")
                    .font(.system(size: 22, weight: .medium, design: .default))
                    .foregroundColor(Color(.label))
                Text("Submitted \(shoppingItem.lastUpdated?.timeStampString ?? "NA")")
                    .font(.system(size: 16))
                    .foregroundColor(Color(.label))
            }
            Spacer()
//            Button(action: {
//                //edit options
//            }) {
//                Image("ellipsis")
//            }
        }.frame(height: 50.0).onAppear {
            self.isChecked = self.shoppingItem.willBePurchased
        }
    }
}

struct ShoppingItemCell_Previews: PreviewProvider {
    static var previews: some View {
        let shoppingItem = ShoppingItem()
        shoppingItem.itemName = "Tofu"
        shoppingItem.lastUpdated = Date()
        return ItemCell(shoppingItem: shoppingItem)
    }
}
