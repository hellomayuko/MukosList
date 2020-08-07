//
//  ShoppingListDataManager.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import CoreData
import MapKit

struct ShoppingListDataManager {
    
    func addNew(list listName: String, store: Store?, context: NSManagedObjectContext) {
        let newList = ShoppingList(context:context)
        newList.id = UUID()
        newList.name = listName
        newList.lastUpdated = Date()
        
        if let store = store {
            let newStore = ShoppingStore(context:context)
            newStore.id = UUID()
            newStore.name = store.name
            newStore.address = store.address
            newStore.latitude = store.coordinates.latitude
            newStore.longitude = store.coordinates.longitude
            
            newList.store = newStore
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateList(name: String, context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingList")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let fetchAttempt = try context.fetch(fetchRequest)
            if fetchAttempt.first != nil {
                return
            }
//            addList(name, context: context)
        } catch {
          print(error)
        }
    }
    
    func fetchList(named name: String, context: NSManagedObjectContext) -> ShoppingList? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingList")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let fetchAttempt = try context.fetch(fetchRequest)
            guard let shoppingList = fetchAttempt.first else {
                return nil
            }
            return shoppingList as? ShoppingList
        } catch {
          print(error)
        }
        return nil
    }
    
    func updateTimestampFor(list: ShoppingList, toDate date: Date, context: NSManagedObjectContext) {
        list.lastUpdated = date
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deletePurchasedItems(fromList list: ShoppingList, context: NSManagedObjectContext) {
//        NSSet *sourceSet =
//            [NSSet setWithObjects:@"One", @"Two", @"Three", @"Four", nil];
//        NSPredicate *predicate =
//            [NSPredicate predicateWithFormat:@"SELF beginswith 'T'"];
//        NSSet *filteredSet =
//            [sourceSet filteredSetUsingPredicate:predicate];
        
//        let itemsToDelete = list.shoppingItems?.filtered(using: NSPredicate(format: "purchased == true"))
//        
//        let itemDataManager = ShoppingItemDataManager()
//        itemDataManager.deleteItems(itemsToDelete, context: context)
        
        let shoppingItems = Array(_immutableCocoaArray: list.shoppingItems!) as [ShoppingItem]

        shoppingItems.forEach { (item) in
            if(item.purchased) {
                context.delete(item)
            }
        }
    }
    
    func deleteList(_ list:ShoppingList, context: NSManagedObjectContext) {
        
        //delete items associated to that list to avoid orphaned items
        list.shoppingItems?.forEach({ item in
            if let item = item as? ShoppingItem {
                context.delete(item)
            }
        })
        context.delete(list)
        
        do {
            try context.save()
        } catch {
            // handle the Core Data error
            print("there was an error)")
        }
    }
}
