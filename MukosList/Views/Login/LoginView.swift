//
//  LoginView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 9/18/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var name: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("KaiMemo").padding(.bottom, 200)
            SignInWithAppleView(name: self.$name).frame(height:70).padding()
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
