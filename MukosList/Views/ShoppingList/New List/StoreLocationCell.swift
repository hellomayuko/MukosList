//
//  StoreLocationCell.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/24/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI
import MapKit

struct StoreLocationCell: View {
    
    @ObservedObject var store: Store
    
    @Binding var setupState: SetupState
    @Binding var listName: String
    @Binding var chosenStore: Store
    
    var body: some View {
        HStack {
            Group {
                VStack(alignment:.leading) {
                    Text(store.name).font(.system(size:22, weight:.medium, design:.default))
                    HStack {
                        Text(store.address).font(.system(size:16, weight:.regular, design:.default))
                        Text("•")
                        Text(store.distanceFromZip).font(.system(size:16, weight:.regular, design:.default))
                    }
                }
                Spacer()
            }.onTapGesture {
                self.chosenStore = self.store
                self.setupState = .creating
            }
            Button(action: {
                self.openMaps()
            }) {
                Image("pin-start").renderingMode(.template).foregroundColor(Color("orange"))
            }.buttonStyle(BorderlessButtonStyle())
        }
    }
    
    func openMaps() {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = store.coordinates
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = store.name
        mapItem.openInMaps(launchOptions: options)
    }
}

struct StoreLocationCell_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        store.name = "HMart"
        store.address = "123 ABC St."
        store.distanceFromZip = "Calculating..."
        return StoreLocationCell(store: store, setupState: .constant(.location), listName: .constant("HMart"), chosenStore: .constant(Store()))
    }
}
