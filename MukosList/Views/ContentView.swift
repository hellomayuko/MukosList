//
//  ContentView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/3/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var selectedView = 1
    
    var body: some View {
        TabView(selection: $selectedView) {
            Text("Favorites Placeholder")
                .tabItem {
                    Image("star")
                }.tag(0)
            HomeListView()
                .environment(\.managedObjectContext, self.managedObjectContext)
                .tabItem {
                    Image("list_home")
                }.tag(1)
            SettingsView()
                .tabItem {
                    Image("gear")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return ContentView().environment(\.managedObjectContext, context)
    }
}
