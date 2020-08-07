//
//  ShoppingList+Extensions.swift
//  MukosList
//
//  Created by Mayuko Inoue on 8/7/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation

extension ShoppingList: Identifiable {

    func numUnpurchasedItems() -> Int {
        let count = self.shoppingItems?.filter({
            !(($0 as! ShoppingItem).purchased)
        }).count
        
        return count ?? 0
    }
}
