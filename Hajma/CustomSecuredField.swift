//
//  CustomSecuredField.swift
//  Hajma
//
//  Created by Rapipay Macintoshn on 19/02/23.
//

import SwiftUI

enum focusedField {
    
}

struct CustomSecuredField: View {
    var title: String
    @Binding var text: String
    @Binding var showError: Bool
    @State var isSecured: Bool = true
    
    @FocusState var securedFocused
    @FocusState var textFocused
    
    init(_ title: String, text: Binding<String>, showError: Binding<Bool>) {
        self.title = title
        self._text = text
        self._showError = showError
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    CustomPasswordField(title, text: $text, showError: $showError)
                        .focused($securedFocused)
                } else {
                    CustomTextField(title, showError: $showError, text: $text)
                        .focused($textFocused)
                }
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(Color.gray)
            }.padding()
        }
    }
}

struct CustomSecuredField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecuredField("Password", text: .constant(""), showError: .constant(false))
    }
}
