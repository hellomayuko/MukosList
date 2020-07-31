//
//  AddLocationView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

enum SetupState {
    case naming, location, creating
//V2    case sharing
    
    var title: String {
        switch(self) {
        case .naming:
            return "Make a New List"
        case .location:
            return "Set Your Store"
//        case .sharing:
//            return "Share Your List"
        default:
            return ""
        }
    }
}

struct AddListView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation
        
    @State var setupState: SetupState = .naming
    @State var listName: String = ""
    @State var store: Store? = Store()
    
    var body: some View {
        VStack {
            if(setupState == .creating) {
                NewListsLoadingView(listName: self.$listName, store: self.$store).environment(\.managedObjectContext, self.managedObjectContext)
            } else {
                Spacer().frame(height:16)
                HStack {
                    Rectangle().frame(height:8).foregroundColor(colorFor(setupState: .naming))
                    Rectangle().frame(height:8).foregroundColor(colorFor(setupState: .location))
    //                Rectangle().frame(height:8).foregroundColor(colorFor(setupState: .sharing))
                }.padding(.horizontal)
                ZStack {
                    HStack {
                        Button(action: {
                            if(self.setupState == .naming) {
                                self.presentation.wrappedValue.dismiss()
                            } else if(self.setupState == .location) {
                                self.setupState = .naming
                            } else {
                                self.setupState = .location
                            }
                        }) {
                            Image("back").renderingMode(.template).foregroundColor(Color("gray_dark"))
                        }.padding(.leading, 28)
                        Spacer()
                    }
                    Text(self.setupState.title)
                        .font(.system(size:24, weight:.semibold, design:.default))
                        .foregroundColor(Color("gray_dark"))
                }.padding(.vertical)
                if(setupState == .naming) {
                    NameListView(setupState: self.$setupState,
                                 listName: self.$listName)
                } else if(setupState == .location) {
                    ChooseStoreView(setupState: self.$setupState,
                                    listName: self.$listName, chosenStore: self.$store)
                        .environment(\.managedObjectContext, self.managedObjectContext)
                } else {
                    Text("haven't made this yet")
                }
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
        AddListView()
    }
}
