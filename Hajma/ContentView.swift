//
//  ContentView.swift
//  Hajma
//
//  Created by Rapipay Macintoshn on 16/02/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var text = ""
    @State var ddText = ""
    @State var mmText = ""
    @State var yyText = ""
    @State var showError = false
    @State var showErrorP = false
    @FocusState var dateIsFocused
    var currentDate = ""
    
    var body: some View {
        VStack {
            CustomTextField("Date of Birth", showError: $showErrorP, text: $text)
                .focused($dateIsFocused)
                .onReceive(Just(text)) {_ in validate()}
            CustomDateField(ddTF: $ddText, mmTF: $mmText, yyTF: $yyText, showError: $showError)
            Button("Validate Data") {
                if !validDate(day: ddText, month: mmText, year: yyText) {
                    showError = true
                    dateIsFocused.toggle()
                }
                print(validDate(day: ddText, month: mmText, year: yyText))
            }
        }.padding()
    }
    
    func validate() {
//        if text.count > 10 {
//            text = String(text.prefix(10))
//        }
        //////////////////////////////////////////////////
//        if text.count >= 3 && text[text.index(text.startIndex, offsetBy: 2)] != "/" && !(text.prefix(2).contains("/")){
//            text.insert("/", at: text.index(text.startIndex, offsetBy: 2))
//        }
//        if text.count >= 6 && text[text.index(text.startIndex, offsetBy: 5)] != "/" && !(text[text.index(text.startIndex, offsetBy: 3)...].contains("/")){
//            text.insert("/", at: text.index(text.startIndex, offsetBy: 5))
//        }
//        ////////////////////////////////////////////////////////////////
//        var currentText = ""
//        for i in text {
//            if i != "/" {
//                currentText.append(i)
//            }
//        }
//        if currentText.count >= 3 {
//            currentText.insert("/", at: currentText.index(currentText.startIndex, offsetBy: 2))
//        }
//        if currentText.count >= 6 {
//            currentText.insert("/", at: currentText.index(currentText.startIndex, offsetBy: 5))
//        }
//        text = currentText
    }
    
    func validDate(day: String, month: String, year: String) -> Bool {
        guard let day = Int(day) else {return false}
        guard let month = Int(month) else {return false}
        guard let year = Int(year) else {return false}
        var m = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if year >= 2023 {
            return false
        }
        if month < 1 || month > 12 {
            return false
        }
        if year % 4 == 0 {
            if !(year % 100 == 0 && year % 400 != 0) {
                m[1] = 29
            }
        }
        if day < 1 || day > m[month-1] {
            return false
        }
        
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
