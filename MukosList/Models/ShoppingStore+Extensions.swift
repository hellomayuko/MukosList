//
//  ShoppingStore+Extensions.swift
//  MukosList
//
//  Created by Mayuko Inoue on 8/21/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import MapKit

extension ShoppingStore: Identifiable {
    
    func getStore() -> Store {
        let store = Store()
        store.name = self.name ?? ""
        store.address = self.address ?? ""
        store.coordinates = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        return store
    }
}
