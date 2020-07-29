//
//  ChooseStoreView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/24/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ChooseStoreView: View {
    @Binding var setupState: SetupState
    @Binding var listName: String
    @Binding var chosenStore: Store
    
    @ObservedObject var nearbyStoresFetcher = NearbyStoresFetcher()
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $nearbyStoresFetcher.storeName)
                    .frame(height: 48.0)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("gray_dark"))
                    .font(.system(size:18, weight:.medium, design:.default))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("gray_light")).padding(.leading, -15)
                        )
                    .padding(.trailing)
                Button(action: {
                    //do something
                }) {
                    Text("Clear")
                        .foregroundColor(Color("gray_medium"))
                        .font(.system(size:18, weight:.semibold, design:.default))
                }
            }.padding(.trailing).padding(.leading, 30)
            Button(action: {
                //do something
            }) {
                Text("Don't set a store")
                    .foregroundColor(Color("gray_medium"))
                    .font(.system(size:18, weight:.regular, design:.default))
            }.padding()
            List(nearbyStoresFetcher.stores) { store in
                StoreLocationCell(store: store, setupState: self.$setupState, listName: self.$listName, chosenStore: self.$chosenStore)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }
        }.onAppear {
            self.nearbyStoresFetcher.storeName = self.listName
        }.onDisappear {
            self.listName = self.nearbyStoresFetcher.storeName
        }
    }
}

struct ChooseStoreView_Previews: PreviewProvider {
    static var previews: some View {
        let fetcher = NearbyStoresFetcher()
        let store = Store()
        store.name = "HMart"
        store.address = "123 ABC St."
        store.distanceFromZip = "Calculating..."
        fetcher.stores = [store]
        return ChooseStoreView(setupState: .constant(.location), listName: .constant("99 Ranch"), chosenStore: .constant(store))
    }
}
