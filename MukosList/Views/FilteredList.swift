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
    var sortDescriptors: [NSSortDescriptor]

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        Group {
            if(self.results.count == 0) {
                VStack {
                    Text("No items").foregroundColor(Color("gray_medium")).padding()
                    Spacer()
                }
            } else {
                List {
                    ForEach(self.results, id: \.self) { result in
                        self.content(result)
                    }.onDelete(perform: self.deleteObjects(_:))
                }
            }
        }
    }

    init(filterKey: String, filterValue: String, performDeletion: @escaping (Set<T>) -> (), sortDescriptors:[NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.performDeletion = performDeletion
        self.sortDescriptors = sortDescriptors
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors:self.sortDescriptors, predicate: NSPredicate(format: "%K == %@", filterKey, filterValue))

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

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
