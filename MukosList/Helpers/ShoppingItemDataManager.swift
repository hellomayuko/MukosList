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

    func scheduleForPurchase(item: ShoppingItem, context: NSManagedObjectContext) {
        /**
          This function schedules an item to be purchased, called from the cell class.
          When the itemView is dismissed, we'll go through and properly mark these as purchased.
          They need to be separate properties because:
        
            1. We don't want the items to disappear on the itemView as soon as they're checked.
            2. We only want to mark items in the itemView as purchased once the itemView is dismissed
            3. Because the itemView doesn't know the state of each cell's "checked"ness, and instead will
               refer to the item state. or something like that.
         */
        item.willBePurchased.toggle()
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func purchasedScheduledItems(_ scheduledItems: [ShoppingItem], context: NSManagedObjectContext) {
        for item in scheduledItems {
            item.purchased.toggle()
        }
        print("SCHEDULEDITEMS")
        print(scheduledItems)
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
