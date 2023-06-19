//
//  PhoneNumberTextFieldView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI
import iPhoneNumberField
import PhoneNumberKit
import UIKit


struct PhoneNumberTextField: View {
    
    @Binding var text: String
    @Binding var isValidNumber: Bool
    private let phoneNumberKit = PhoneNumberKit()
    @State var ttxt = "text"
    
    var body: some View {
        iPhoneNumberField(text: $ttxt)
                .autofillPrefix(true)
//        content
//            .onChange(of: text) { newValue in
//                self.isValidNumber = self.isValidPhoneNumber(phoneNumber: newValue)
//            }
    }
    
    @MainActor
    private var content: some View {
        textField
    }
    
    
    private var textField: some View {
        iPhoneNumberField(text: $text)
//            .font(UIFont(name: "Roboto-Regilar", size: 17))
//            .foregroundColor(Colors.primary)
//            .prefixHidden(false)
//            .autofillPrefix(true)
//            .flagHidden(false)
//            .flagSelectable(true)
//            .roundedBorderModifier(borderColor: Colors.neutral)
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        return phoneNumberKit.isValidPhoneNumber(phoneNumber)
    }
    
}
