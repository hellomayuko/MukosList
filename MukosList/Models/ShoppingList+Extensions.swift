//
//  ShoppingList+Extensions.swift
//  MukosList
//
//  Created by Mayuko Inoue on 8/7/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation

extension ShoppingList {
    
    func numItemsNotPurchased() -> Int {
        let scheduledItems = self.shoppingItems?.filter { (item) -> Bool in
            let itemCasted = item as? ShoppingItem
            let value = !(itemCasted?.willBePurchased ?? false) && !(itemCasted?.purchased ?? false)
            return value
        }
        
        return scheduledItems?.count ?? 0
    }

    func numUnpurchasedItems() -> Int {
        let count = self.shoppingItems?.filter({
            !(($0 as! ShoppingItem).purchased)
        }).count
        
        return count ?? 0
    }
}
