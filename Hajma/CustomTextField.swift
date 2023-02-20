//
//  CustomTextField.swift
//  Hajma
//
//  Created by Rapipay Macintoshn on 17/02/23.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    @Binding var showError: Bool
    @Binding var text: String
    
    @State private var borderColor = Color(.gray)
    @FocusState private var showLabel
    
    init(_ title: String, showError: Binding<Bool>, text: Binding<String>) {
        self.title = title
        self._showError = showError
        self._text = text
    }
    
    var body: some View {
        ZStack {
            TextField(title, text: $text, onEditingChanged: { isStarted in
                if isStarted {
                    borderColor = showError ? Color(.red) : Color(.blue)
                } else {
                    borderColor = showError ? Color(.red) : Color(.gray)
                }
            }).onChange(of: text, perform: { data in
                showError = false
                borderColor = showError ? Color(.red) : Color(.blue)
            }).onSubmit {
                borderColor = showError ? Color(.red) : Color(.gray)
            }.focused($showLabel)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(borderColor, lineWidth: 2)
            }
            
            if showLabel {
                HStack {
                    Text(title)
                        .padding(.horizontal, 5)
                        .background(Color.white)
                    Spacer()
                }.padding(.bottom, 50)
                    .padding(.leading, 20)
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField("TextField", showError: .constant(false), text: .constant(""))
    }
}
