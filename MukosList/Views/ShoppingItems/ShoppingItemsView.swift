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
            NSSortDescriptor(keyPath: \ShoppingItem.lastUpdated, ascending: false),
        ]
    ) var shoppingItems: FetchedResults<ShoppingItem>
    
    @State var shoppingList: ShoppingList
    @State var itemName: String = ""
    @State private var toggleBusynessView: Bool = false
    @State private var setupState: SetupState = .renaming //if the user goes into edit flow
    @State private var presentEditSheet = false
    
    var dataManager = ShoppingItemDataManager()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .renderingMode(.template)
                        .foregroundColor(Color.black)
                        .frame(width: 24, height: 24)
                }
                Spacer()
                Button(action: {
                    //do something
                    self.presentEditSheet = true
                }) {
                    Text("Edit")
                        .foregroundColor(Color("gray_medium"))
                        .font(.system(size: 22))
                }
            }.padding()
            Group {
                HStack {
                    Text(shoppingList.name ?? "").font(.system(size: 32, weight: .bold, design: .default))
                    Spacer()
                }
                HStack {
                    Text(shoppingList.store?.address ?? "")
                        .foregroundColor(Color("gray_dark"))
                        .font(.system(size: 18))
                    Spacer()
                }
                /* V2: Showing popular times using Google's API (which costs $$$)
                HStack {
                    Text("• Live \(Date().currentTimeString) :")
                        .foregroundColor(Color("orange_dark"))
                        .font(.system(size: 18, weight: .medium, design: .default))
                    
                    Button(action: {
                        //unfold and show stats
                        self.toggleBusynessView.toggle()
                    }) {
                        HStack {
                            Text(LocationHelper.busyLevel())
                                .foregroundColor(Color("gray_dark"))
                                .font(.system(size: 18))
                            Image(systemName:"chevron.right")
                                .renderingMode(.template)
                                .foregroundColor(Color("gray_dark"))
                        }
                    }
                    Spacer()
                }
                if self.toggleBusynessView {
                    Rectangle().foregroundColor(Color.orange).animation(.easeIn)
                }
                */
            }.padding(.leading, 19)
            HStack {
                Spacer().frame(width:24)
                TextFieldView(placeholder: "Enter items", text: $itemName) {
                    guard let listName = self.shoppingList.name else {
                        return
                    }
                    self.dataManager.addItem(self.itemName, toList: listName, quantity: 1, highPriority: false, context: self.managedObjectContext)
                    self.itemName = ""
                }
                    .frame(height: 48.0)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(.label))
                    .font(.system(size:18, weight:.medium, design:.default))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(.systemFill))
                            .padding(.leading, -15)
                    )
                    .padding(.leading, 15)
                Spacer().frame(width:24)
            }.padding(.vertical)
            Spacer()
            HStack(alignment: .top) {
                FilteredList(predicates: [
                                NSPredicate(format: "%K == %@", "shoppingList.name", self.shoppingList.name ?? "default"),
                                NSPredicate(format: "%K == %@", "purchased", false)
                            ],
                             performDeletion: self.performDelete,
                             sortDescriptors: [
                                NSSortDescriptor(keyPath: \ShoppingItem.lastUpdated, ascending: false),
                    ])
                { (shoppingItem: ShoppingItem) in
                    ItemCell(shoppingItem: shoppingItem)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 6)
                }
            }
        }
        .navigationBarTitle(Text(self.shoppingList.name ?? "default"
        ))
        .navigationBarItems(trailing:
            Button("Edit") {
                print("hello")
            }.foregroundColor(Color("gray_medium"))
        ).onDisappear {
            let scheduledItems = self.shoppingItems.filter { (item) -> Bool in
                let value = item.willBePurchased && !item.purchased
                return value
            }
            //This is a jank way to go around my crash. I'm guessing that because I'm updating things in CoreData
            //right as this view dismisses, the List tries to render the new update as a result of this call but
            //because it's getting dealloc'd and removed from the view, it gets in a weird state and crashes.
            //The only thing that the crash stack shows is this call: PlaceholderInfo.reuseItem(info:placeholder:context:) ()
            //This sounds kinda Apple/reusing cells in a list-related. But like, i have no idea how to debug that. so. here we are.
            //So who actually knows what could be going on tho, the stack trace for this is tiny and doesn't help at all. /shrug
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.dataManager.purchasedScheduledItems(scheduledItems, context: self.managedObjectContext)
            }
        }.sheet(isPresented: self.$presentEditSheet) {
            AddListView(setupState: self.$setupState, listName: self.shoppingList.name, store: self.shoppingList.store?.getStore(), uid: self.shoppingList.id).environment(\.managedObjectContext, self.managedObjectContext)
        }
    }
    
    func performDelete(_ objects: Set<ShoppingItem>) {
        self.dataManager.deleteItems(objects, context: self.managedObjectContext)
    }
    
    func lastUpdatedString() -> String {
        if let lastUpdatedDate = self.dataManager.fetchUpdatedAtFor(list: self.shoppingList.name ?? "default", context: self.managedObjectContext) {
            return "Saved \(lastUpdatedDate.timeStampString)"
        }
        return ""
    }
}

struct ShoppingItemsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let list = SwiftUIPreviewHelper.createList(withContext: context, withItems: true)
        
        return Group {
            ShoppingItemsView(shoppingList: list).environment(\.managedObjectContext, context)
            ShoppingItemsView(shoppingList: list).environment(\.managedObjectContext, context)
            ShoppingItemsView(shoppingList: list).environment(\.managedObjectContext, context)
        }
    }
}
