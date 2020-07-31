//
//  NewListsLoadingView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 7/28/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

struct NewListsLoadingView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentation
    
    @Binding var listName: String
    @Binding var store: Store?
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)
            HStack {
                ActivityIndicator(isAnimating: .constant(true), style: .large)
                Text("Creating List...")
                   .font(.system(size:24, weight:.bold, design:.default))
                   .foregroundColor(Color("gray_dark"))
                   .animation(.easeInOut)
            }
            
        }.onAppear {
            self.startTimer()
            let dataManager = ShoppingListDataManager()
            dataManager.addNew(list: self.listName, store: self.store, context: self.managedObjectContext)
        }
    }
    
    func startTimer() {
        let _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.presentation.wrappedValue.dismiss()
        }
    }
}

struct NewListsLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        NewListsLoadingView(listName: .constant("HMart"), store: .constant(Store()))
    }
}

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
