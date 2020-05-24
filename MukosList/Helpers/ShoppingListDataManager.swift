//
//  ShoppingListDataManager.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import CoreData

struct ShoppingListDataManager {

    func addList(_ listName: String, context: NSManagedObjectContext) {
        let newList = ShoppingList(context:context)
        newList.id = UUID()
        newList.name = listName
        newList.lastUpdated = Date()
        
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
            addList(name, context: context)
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
}
