//
//  HomeListView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/15/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct HomeListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: ShoppingList.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ShoppingList.lastUpdated, ascending: false),
        ]
    ) var shoppingLists: FetchedResults<ShoppingList>
    
    @State var presentAddItemView = false
    @State var showAddListView = false
    let greyColor = Color("medium_gray")
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center) {
                    Text("\(Date().greeting), Mayuko")
                        .padding(.leading, 24)
                        .font(.title)
                        .foregroundColor(Color.white)
                    Spacer()
                    Circle()
                        .foregroundColor(Color.blue)
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding(.trailing, 24)
                    }.frame(height: 200).background(Color("orange"))
                NewListButton(showAddListView: $showAddListView).environment(\.managedObjectContext, self.managedObjectContext)
                Spacer()
                List(shoppingLists, id: \.self) { shoppingList in
                    NavigationLink(destination: ShoppingItemsView(isBeingPresented: self.$presentAddItemView, isPresentedFromAddListView:.constant(false), listName: shoppingList.name ?? "idk").environment(\.managedObjectContext, self.managedObjectContext)) {
                        ListCell(presentAddItemView: self.$presentAddItemView, list: shoppingList).environment(\.managedObjectContext, self.managedObjectContext)
                    }
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct HomeListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
