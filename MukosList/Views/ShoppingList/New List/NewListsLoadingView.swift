//
//  NewListsLoadingView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/28/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct NewListsLoadingView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var listName: String
    @Binding var store: Store
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)
            Text("Henlo")
        }.onAppear {
            let dataManager = ShoppingListDataManager()
            dataManager.addNew(list: self.listName, store: self.store, context: self.managedObjectContext)
        }
    }
}

struct NewListsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        NewListsLoadingView(listName: .constant("HMart"), store: .constant(Store()))
    }
}
