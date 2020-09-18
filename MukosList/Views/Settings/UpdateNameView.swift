//
//  UpdateNameView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 9/18/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct UpdateNameView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var username: String
    
    private let settingsHelper = SettingsHelper()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Edit Your Name")
                .font(.headline)
                .foregroundColor(Color("gray_dark"))
                .padding(.bottom, 12.0)
            TextField("", text: $username, onCommit:  {
                settingsHelper.updateUsername(self.username)
            }).frame(height: 56.0)
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("gray_dark"))
                .font(.system(size:24, weight:.bold, design:.default))
            Rectangle()
                .frame(height:2)
                .padding(.horizontal, 40)
                .padding(.top, -20)
                .foregroundColor(Color("gray_dark"))
            Button(action: {
                settingsHelper.updateUsername(self.username)
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .foregroundColor(Color("orange"))
                    .font(.system(size:18, weight:.bold, design:.default))
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 118)
                            .frame(height:40)
                            .foregroundColor(Color.white)
                            .shadow(color: .gray, radius: 1, x: 0, y: 0)
                    )
            }.padding(.vertical)
            Spacer().frame(height:350)
        }
    }
}

struct UpdateNameView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateNameView(username: .constant("mayuko"))
    }
}
