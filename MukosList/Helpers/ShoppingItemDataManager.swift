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
        let currentDate = Date()
        
        let newItem = ShoppingItem(context:context)
        newItem.id = UUID()
        newItem.lastUpdated = currentDate
        
        newItem.itemName = itemName
        newItem.quantity = Int16(quantity)
        newItem.highPriority = highPriority
        
        let listDataManager = ShoppingListDataManager()
        if let shoppingList = listDataManager.fetchList(named:list, context: context) {
            shoppingList.lastUpdated = currentDate
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
            if let shoppingList = shoppingItem.shoppingList {
                let listDataManager = ShoppingListDataManager()
                listDataManager.updateTimestampFor(list: shoppingList, toDate: Date(), context: context)
            }
            
            context.delete(shoppingItem)
        }
    }
    
    func toggleItem(item: ShoppingItem, context: NSManagedObjectContext) {
        item.purchased.toggle()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUpdatedAtFor(list: String, context: NSManagedObjectContext) -> Date? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingList")
        fetchRequest.predicate = NSPredicate(format: "name == %@", list)
        fetchRequest.fetchLimit = 1
        
        do {
            let fetchAttempt = try context.fetch(fetchRequest)
            guard let list = fetchAttempt.first as? ShoppingList else {
                return nil
            }
            return list.lastUpdated
        } catch {
          print(error)
        }
        return nil
    }
}
