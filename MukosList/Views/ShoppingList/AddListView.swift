//
//  AddLocationView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

enum SetupState {
    case naming
    case location
    case sharing
}

struct AddListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation
    
    @Binding var showAddListView: Bool
    @State var setupState: SetupState = .naming
    @State var listName = ""
    
    var titleForCurrentState: String {
        if(setupState == .naming) {
            return "Make a New List"
        } else if(setupState == .location) {
            return "Set Your Store"
        } else {
            return "Share Your List"
        }
    }

    var body: some View {
        VStack {
            Spacer().frame(height:16)
            HStack {
                Rectangle().frame(height:8).foregroundColor(colorFor(setupState: .naming))
                Rectangle().frame(height:8).foregroundColor(colorFor(setupState: .location))
                Rectangle().frame(height:8).foregroundColor(colorFor(setupState: .sharing))
            }.padding(.horizontal)
            ZStack {
                HStack {
                    Button(action: {
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Image("back").renderingMode(.template).foregroundColor(Color("gray_dark"))
                    }.padding(.leading, 28)
                    Spacer()
                }
                Text(titleForCurrentState)
                    .font(.system(size:24, weight:.semibold, design:.default))
                    .foregroundColor(Color("gray_dark"))
            }.padding(.vertical)
            if(self.setupState == .naming) {
                NameListView(setupState: self.$setupState, listName: self.$listName)
            } else {
                Text("not setup yet")
            }
        }
    }
    
    func colorFor(setupState: SetupState) -> Color {
        if(setupState == self.setupState) {
            return Color("orange")
        } else {
            return Color("gray_light")
        }
    }
}


struct AddListView_Previews: PreviewProvider {
    static var previews: some View {
        AddListView(showAddListView: .constant(true))
    }
}
