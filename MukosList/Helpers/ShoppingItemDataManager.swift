//
//  ShoppingItemDataManager.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import CoreData

struct ShoppingItemDataManager {
    func addItem(_ itemName: String, toList list: String, quantity: Int, highPriority: Bool,  context: NSManagedObjectContext) {
        let newItem = ShoppingItem(context:context)
        newItem.id = UUID()
        newItem.lastUpdated = Date()
        
        newItem.itemName = itemName
        newItem.quantity = Int16(quantity)
        newItem.highPriority = highPriority
        
        let listDataManager = ShoppingListDataManager()
        if let shoppingList = listDataManager.fetchList(named:list, context: context) {
            newItem.shoppingList = shoppingList
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
