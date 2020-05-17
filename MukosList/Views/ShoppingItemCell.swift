//
//  ShoppingItemCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    var shoppingItem: ShoppingItem

    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(shoppingItem.itemName ?? "idk")
                    .font(.headline)
                    .foregroundColor(Color("text_grey"))
                Text("Submitted \(shoppingItem.lastUpdated?.timeStampString ?? "NA")")
                    .font(.footnote)
                    .foregroundColor(Color("text_grey"))
            }
            Spacer()
            Button(action: {
                //edit options
            }) {
                Image("ellipsis")
            }
        }.frame(height: 50.0)
    }
}
