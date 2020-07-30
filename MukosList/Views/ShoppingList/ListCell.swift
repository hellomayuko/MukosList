//
//  ListCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ListCell: View {
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
            Button(action: {
                
            }) {
                Image("ellipsis").padding(.trailing, 30) //this padding is to make sure the ellipses show since we did a weird thing to hide the ">" symbol that shows because it's a NavigationLink. shrug
            }
        }
        .frame(height: 60.0)
    }
}

struct ListCell_Previews: PreviewProvider {
    static var previews: some View {
        
        let list = ShoppingList()
        list.name = "99 Ranch"
        list.shoppingItems = ["Bok Choy", "Soy Sauce"]

        return ListCell(presentAddItemView: .constant(true), list: list)
    }
}
