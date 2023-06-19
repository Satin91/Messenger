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
    private let phoneNumberKit = PhoneNumberKit()
    
    /// В библиотеке iPhoneNumberField была допущена ошибка, изза чего наблюдатель за заполнением префикса номера телефона (+n) провоцирует пересоздание текстового поля, изза чего грузится оперативная память. Сейчас был выбран обходной путь,  но по хорошему нужно редактировать саму библиотеку.
    @State private var updatingView: Bool = true
    
    var body: some View {
        content
            .onChange(of: text) { newValue in
                self.isValidNumber = self.isValidPhoneNumber(phoneNumber: newValue)
//                let countryCode = phoneNumberKit.mainCountry(forCode: newValue.suffix(3))
//                print(countryCode)
//                self.phoneNumberKit.getExampleNumber(forCountry: "")
            }
    }
    
    private var content: some View {
        textField
    }
    
    
    private var textField: some View {
        iPhoneNumberField("", text: $text)
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
