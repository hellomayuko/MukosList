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
    var list: ShoppingList
    @State var notShowingNewListFlow = false
    
    var body: some View {
        HStack {
            Image("add_yellow")
            VStack(alignment:.leading){
                Text(list.name ?? "N/A")
                    .font(.headline)
                
                Text("\(list.shoppingItems!.count) items")
                    .font(.subheadline)
            }
            .padding(.leading, 15.0)
            Spacer()
        }
        .frame(height: 60.0)
    }
}

//struct ListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let shoppingList = ShoppingList()
//        shoppingList.name = "Test List"
//        shoppingList.shoppingItems = ["Blueberry", "Strawberry"]
//
//        return ListCell(presentAddItemView: .constant(true), list: shoppingList)
//    }
//}
