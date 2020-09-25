//
//  ContainerTabView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 9/25/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct ContainerTabView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var currentView: String = "home"
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if self.currentView == "home" {
                    HomeListView().environment(\.managedObjectContext, self.managedObjectContext)
                } else if self.currentView == "settings" {
                    SettingsView()
                } else if self.currentView == "favorites" {
                    Text("Favorites Placeholder")
                }
                Spacer()
                    ZStack {
                        HStack {
                            Image(systemName: "star")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width/3 - 30,
                                       height: 75)
                                .padding(.leading, 45)
                                .foregroundColor(self.currentView == "favorites" ? .black : .gray)
                                .onTapGesture {
                                    self.currentView = "favorites"
                                }
                            Spacer()
                            Image(systemName: "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .frame(width: geometry.size.width/3 - 30, height: 77)
                                .padding(.trailing, 45)
                                .foregroundColor(self.currentView == "settings" ? .black : .gray)
                                .onTapGesture {
                                    self.currentView = "settings"
                                }
                        }
                        Image("list_home")
                            .frame(width: geometry.size.width/3 - 30, height: 110, alignment:.top)
    //                        .offset(x: 0, y: -40)
                            .onTapGesture {
                            self.currentView = "home"
                        }
                    }
                    .frame(width: geometry.size.width, height: 90, alignment:.bottom)
                    .background(Color.white.cornerRadius(20, corners: .topLeft).cornerRadius(20, corners: .topRight).shadow(color: .gray, radius: 5, x: 0.0, y: 0))
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContainerTabView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContainerTabView()
            ContainerTabView()
        }
    }
}
