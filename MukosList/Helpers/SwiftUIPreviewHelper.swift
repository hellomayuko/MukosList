//
//  SwiftUIPreviewHelper.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/31/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import CoreData

class SwiftUIPreviewHelper {
    class func createList(withContext context: NSManagedObjectContext, withItems shouldCreateItems:Bool) -> ShoppingList {
        let dataManager = ShoppingListDataManager()
        
        let storeName = "99 Ranch"
        let store = Store()
        store.name = storeName
        store.address = "123 ABC St."
        
        dataManager.addNew(list: storeName, store: store, context: context)
        
        if(shouldCreateItems) {
            let itemManager = ShoppingItemDataManager()
            itemManager.addItem("Bok Boy", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
            itemManager.addItem("Rogel for Kurthiam", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
            itemManager.addItem("Tapioca Pearls", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
            itemManager.addItem("Ice Cream", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
            itemManager.addItem("Salmon", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
            itemManager.addItem("Pudding", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
            itemManager.addItem("Fluffy cheesecake", toList: "99 Ranch", quantity: 1, highPriority: false, context: context)
        }
        
        let list = dataManager.fetchList(named: storeName, context: context)
        return list!
    }
}
