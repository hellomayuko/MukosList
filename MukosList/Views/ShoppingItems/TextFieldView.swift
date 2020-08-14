//
//  TextFieldView.swift
//  MukosList
//
//  Created by Mayuko Inoue on 8/14/20.
//  Copyright © 2020 Mayuko Inoue. All rights reserved.
//

import SwiftUI

/*
  A UITextField wrapper that is pretty similar to SwiftUI's TextField,
  except that this class doesn't dismiss the keyboard when pressing enter
*/
struct TextFieldView: UIViewRepresentable {
    let placeholder: String?
    @Binding var text: String
    let onCommit: (() -> Void)?
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, text: $text)
    }
        
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldView
        @Binding var textValue: String
        
        init(_ textField: TextFieldView, text: Binding<String>) {
            self.parent = textField
            _textValue = text
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let text = textField.text {
                self.textValue = text
            }
            
            if let commit = self.parent.onCommit {
                commit()
            }
            //Keep the keyboard up
            return false
        }
    }
}
