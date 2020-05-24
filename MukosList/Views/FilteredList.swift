//
//  FilteredList.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var results: FetchedResults<T> { fetchRequest.wrappedValue }
    var performDeletion: (Set<T>) -> () = {_ in }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List {
            ForEach(self.results, id: \.self) { result in
                self.content(result)
            }.onDelete(perform: self.deleteObjects(_:))
        }
    }

    init(filterKey: String, filterValue: String, performDeletion: @escaping (Set<T>) -> (), @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", filterKey, filterValue))
        self.content = content
        self.performDeletion = performDeletion
    }
    
    func deleteObjects(_ offsets: IndexSet) {
        self.performDeletion(objectsToDelete(at: offsets))
    }
    
    func objectsToDelete(at offsets: IndexSet) -> Set<T> {
        var objectSet: Set<T> = Set()
        
        for index in offsets {
            let result = results[index]
            objectSet.insert(result)
        }
        return objectSet
    }
}
