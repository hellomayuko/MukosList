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
        let newItem = ShoppingList(context:context)
        newItem.id = UUID()
        newItem.name = listName
        
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
            guard let shoppingList = fetchAttempt.first else {
                addList(name, context: context)
                return
            }
            (shoppingList as! NSManagedObjectContext).setValue(name, forKey: "name")
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
//            (shoppingList as! NSManagedObjectContext).setValue(name, forKey: "name")
        } catch {
          print(error)
        }
        return nil
    }
}
