//
//  CheckmarkView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 6/19/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct CheckmarkView: View {
    @State var isChecked: Bool
    
    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            isChecked ? Image("checkmark_true") : Image("checkmark_false")

        }.buttonStyle(PlainButtonStyle())
    }
}

struct CheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView(isChecked: true)
    }
}
