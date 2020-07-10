//
//  SearchButton.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button(action: {
            //edit options
        }) {
            HStack {
                Image("search")
                Text("Search").fontWeight(.medium).foregroundColor(Color("gray_mediumDark"))
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton()
    }
}
