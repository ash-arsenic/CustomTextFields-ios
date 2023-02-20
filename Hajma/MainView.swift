//
//  MainView.swift
//  Hajma
//
//  Created by Rapipay Macintoshn on 19/02/23.
//

import SwiftUI

struct MainView: View {
    @State var emailData: String = ""
    @State var pswdData: String = ""
    @State var emailShowError: Bool = false
    @State var pswdShowError: Bool = false
    
    @FocusState var emailIsFocused: Bool
    @FocusState var pswdIsFocused: Bool

    var body: some View {
        VStack {
            CustomTextField("Email", showError: $emailShowError, text: $emailData)
                .focused($emailIsFocused)
                .onSubmit {
                    emailShowError = !isValidEmail(emailData)
                    pswdIsFocused.toggle()
                }
            
            CustomSecuredField("Password", text: $pswdData, showError: $pswdShowError)
                .focused($pswdIsFocused)
                .onSubmit {
                    if pswdData != "parda433" {
                        pswdShowError = true
                        pswdIsFocused.toggle()
                    }
                }
            
            Button("Login") {
                pswdShowError = true
                pswdIsFocused.toggle()
            }
        }.padding()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
