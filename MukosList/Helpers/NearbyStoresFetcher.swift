//
//  NearbyLocationsFetcher.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/24/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import Foundation
import MapKit
import Combine

struct Store: Identifiable {
    var id = UUID()
    var name: String
    var address: String
    var distanceFromZip: String
}

class NearbyStoresFetcher: NSObject, ObservableObject {
    @Published var stores = [Store]()
    @Published var storeName = ""
        
    let locationManager = CLLocationManager()
    private var currentRegion: MKCoordinateRegion?
    
    var nameCancellable: AnyCancellable?
    
    override init(){
        super.init()
        
        nameCancellable = $storeName
            .dropFirst(1)
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] name in
                print(name)
                self?.fetchData(for: name)
        }
        
        setupLocationServices()
        self.fetchData(for: self.storeName)
    }
    
    func setupLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func fetchData(for storeName: String) {
        guard let region = currentRegion else {
            stores = []
            return
        }
        
        if storeName.isEmpty {
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = storeName
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print(response.mapItems)
            
            var newStores = [Store]()
            
            response.mapItems.forEach { (mapItem) in
                guard let name = mapItem.name, let streetName = mapItem.placemark.thoroughfare else {
                    return
                }
                let newStore = Store(name: name, address: streetName, distanceFromZip: "idk")
                newStores.append(newStore)
            }
            self.stores = newStores
        }
    }
}

extension NearbyStoresFetcher: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status.rawValue >= 3) {
            fetchData(for: self.storeName)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            currentRegion = MKCoordinateRegion(center: location.coordinate, span: span)
            fetchData(for: self.storeName)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
