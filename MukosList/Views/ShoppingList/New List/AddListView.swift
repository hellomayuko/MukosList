//
//  AddLocationView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 5/10/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

enum SetupState {
    case naming, renaming
    case location, relocating
    case creating, editing
//V2    case sharing

    var title: String {
        switch(self) {
        case .naming:
            return "Make a New List"
        case .renaming:
            return "Edit Your List"
        case .location:
            return "Set Your Store"
        case .relocating:
            return "Edit Your Location"
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

    @Binding var setupState: SetupState

    @State var listName: String = ""
    @State var store: Store? = Store()

    var uid: UUID?

    init(setupState: Binding<SetupState>, listName: String?, store: Store?, uid: UUID?) {
        _setupState = setupState
        _listName = State(initialValue: listName ?? "")
        self.store = store

        self.uid = uid
    }

    var body: some View {
        VStack {
            if(setupState == .creating || self.setupState == .editing) {
                NewListsLoadingView(setupState: self.$setupState, listName: self.$listName, store: self.$store, uid: self.uid).environment(\.managedObjectContext, self.managedObjectContext)
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
                            if(self.setupState == .naming || self.setupState == .renaming) {
                                self.presentation.wrappedValue.dismiss()
                            } else if(self.setupState == .location) {
                                self.setupState = .naming
                            } else if(self.setupState == .relocating) {
                                self.setupState = .renaming
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
                        .foregroundColor(Color(.secondaryLabel))
                    if(self.setupState == .location || self.setupState == .relocating) {
                        HStack {
                            Spacer()
                            Button(action: {
                                if(self.setupState == .location) {
                                    self.setupState = .creating
                                } else {
                                    self.setupState = .editing
                                }
                            }) {
                                Text(self.setupState == .location ? "Create":"Edit").foregroundColor(Color("orange")).font(.system(size:18, weight:.semibold, design:.default))
                            }.padding(.trailing, 28)
                        }
                    }
                }.padding(.vertical)
                if(setupState == .naming || self.setupState == .renaming) {
                    NameListView(setupState: self.$setupState,
                                 listName: self.$listName)
                } else if(setupState == .location || self.setupState == .relocating) {
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
        AddListView(setupState: .constant(.naming), listName: nil, store: nil, uid: nil)
    }
}
