//
//  AddItemView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    @Binding var isShowingNewLocationFlow: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isShowingNewLocationFlow: .constant(true))
    }
}
