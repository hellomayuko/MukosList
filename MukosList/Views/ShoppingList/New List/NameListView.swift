//
//  NameListView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/17/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

enum NameListAction {
    case skip, create, edit
}

struct NameListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Binding var setupState: SetupState
    @Binding var listName: String
    
    @State var actionButtonState: NameListAction = .skip
    
    var dataManager = ShoppingListDataManager()
    
    init(setupState: Binding<SetupState>, listName: Binding<String>) {
        _setupState = setupState
        _listName = listName
    
        if(listName.wrappedValue != "") {
            _actionButtonState = .init(wrappedValue: .edit)
            print("woah")
        }
        print(listName)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Give your list a name")
                .font(.headline)
                .foregroundColor(Color("gray_dark"))
                .padding(.bottom, 12.0)
            TextField("", text: $listName, onEditingChanged: {_ in
                if(self.actionButtonState == .skip) {
                    self.actionButtonState = .create
                }
            }, onCommit: {
//                Call update instead of add just in case we already
//                have a list of the same name
                self.dataManager.updateList(name: self.listName, context: self.managedObjectContext)
            }) .frame(height: 56.0)
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
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                if(self.setupState == .naming) {
                    self.setupState = .location
                } else if(self.setupState == .renaming) {
                    self.setupState = .relocating
                }
            }) {
                if(self.actionButtonState == .skip) {
                    Text("No Thanks")
                        .foregroundColor(Color("gray_medium"))
                        .font(.system(size:18, weight:.bold, design:.default))
                } else if(self.actionButtonState == .edit) {
                    Text("Edit")
                        .foregroundColor(Color("orange"))
                        .font(.system(size:18, weight:.bold, design:.default))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 118)
                                .frame(height:40)
                                .foregroundColor(Color.white)
                                .shadow(color: .gray, radius: 1, x: 0, y: 0)
                        )
                } else {
                    Text("Create")
                        .foregroundColor(Color("orange"))
                        .font(.system(size:18, weight:.bold, design:.default))
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 118)
                                .frame(height:40)
                                .foregroundColor(Color.white)
                                .shadow(color: .gray, radius: 1, x: 0, y: 0)
                        )
                }
            }.padding(.vertical)
            Spacer().frame(height:350)
        }
    }
}

struct NameListView_Previews: PreviewProvider {
    static var previews: some View {
        NameListView(setupState: .constant(.naming), listName: .constant("Vons"))
    }
}
