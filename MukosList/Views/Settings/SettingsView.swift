//
//  SettingsView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 9/18/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    private let settingsHelper = SettingsHelper()
    @State var username = ""
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UpdateNameView(username: self.$username)) {
                    HStack {
                        Text("Name").font(.headline)
                        Spacer()
                        Text(self.username).font(.subheadline)
                    }
                }.frame(height: 60)
                HStack {
                    Text("Profile Picture").font(.headline)
                    Spacer()
                    Circle()
                    .foregroundColor(Color.blue)
                    .frame(width: 40, height: 40, alignment: .center)
                    Button(action: {
                        //edit name flow
                    }) {
                        Image(systemName: "chevron.right").renderingMode(.template).foregroundColor(Color("gray_medium"))
                    }
                }.frame(height: 60)
                Button(action: {
                    //edit name flow
                }) {
                    Text("Erase All Data").font(.body).foregroundColor(Color("gray_medium"))
                }.frame(height: 40)
            }.onAppear {
                self.username = settingsHelper.fetchUserName()
            }.navigationBarTitle("Settings")
            .padding(.top, 20)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(username: "Mayuko")
    }
}
