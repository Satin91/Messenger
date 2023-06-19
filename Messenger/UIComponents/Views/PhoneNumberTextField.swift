//
//  PhoneNumberTextField.swift
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
    @State var filteredText: String = "" {
        willSet {
            print(newValue)
        }
    }
    private let phoneNumberKit = PhoneNumberKit()
    
    @State private var updatingView: Bool = true
    
    var body: some View {
        content
            .onChange(of: text) { newValue in
                self.isValidNumber = self.isValidPhoneNumber(phoneNumber: newValue)
                print(filteredText)
            }
    }
    
    private var content: some View {
        textField
    }
    
    
    private var textField: some View {
        iPhoneNumberField("+7 923 222-44-22", text: $text)
            .font(UIFont(name: "Roboto-Regilar", size: 17))
            .foregroundColor(Colors.primary)
            .prefixHidden(false)
            .onNumberChange { num in
                insertSuffix()
            }
            .flagHidden(false)
            .flagSelectable(true)
            .roundedBorderModifier(borderColor: Colors.neutral)
    }
    
    func isValidPhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        return phoneNumberKit.isValidPhoneNumber(phoneNumber)
    }
    
    
    func insertSuffix() {
        if text.count > 1 && text.suffix(1) != "+" {
            text.insert("+", at: text.startIndex)
        }
    }
}
