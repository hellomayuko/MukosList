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
    
    func deleteItems(_ items:Set<ShoppingItem>, context: NSManagedObjectContext) {
        for shoppingItem in items {
            context.delete(shoppingItem)
        }
    }
    
    func fetchUpdatedAtFor(list: String, context: NSManagedObjectContext) -> Date? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingItem")
        fetchRequest.predicate = NSPredicate(format: "shoppingList.name == %@", list)
        fetchRequest.fetchLimit = 1
        
        let updatedDatSort = NSSortDescriptor(key:"lastUpdated", ascending:false)
        fetchRequest.sortDescriptors = [updatedDatSort]
        
        do {
            let fetchAttempt = try context.fetch(fetchRequest)
            guard let item = fetchAttempt.first as? ShoppingItem else {
                return nil
            }
            return item.lastUpdated
        } catch {
          print(error)
        }
        return nil
    }
}
