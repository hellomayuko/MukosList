//
//  StoreLocationCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/24/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct StoreLocationCell: View {
    @ObservedObject var store: Store
    
    var body: some View {
        HStack {
            VStack(alignment:.leading) {
                Text(store.name).font(.system(size:22, weight:.medium, design:.default))
                HStack {
                    Text(store.address).font(.system(size:16, weight:.regular, design:.default))
                    Text("•")
                    Text(store.distanceFromZip).font(.system(size:16, weight:.regular, design:.default))
                }
            }
            Spacer()
            Button(action: {
                //do something, idk yet
            }) {
                Image("pin-start").renderingMode(.template).foregroundColor(Color("orange"))
            }
        }
    }
}

struct StoreLocationCell_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        store.name = "HMart"
        store.address = "123 ABC St."
        store.distanceFromZip = "Calculating..."
        
        return StoreLocationCell(store: store)
    }
}
