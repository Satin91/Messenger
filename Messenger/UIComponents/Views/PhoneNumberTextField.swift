//
//  PhoneNumberTextFieldView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI
import iPhoneNumberField

struct PhoneNumberTextField: View {
    
    @Binding var text: String
    var isEditing: Bool {
        !text.isEmpty
    }
    
    var body: some View {
        content
    }
    
    private var content: some View {
        textField
    }
    
    private var textField: some View {
        iPhoneNumberField("", text: $text)
            .prefixHidden(false)
            .flagHidden(false)
            .maximumDigits(12)
            .flagSelectable(true)
            .defaultRegion(Locale.current.regionCode)
            .onNumberChange { _ in
                updateTextWithPrefix()
            }
            .font(UIFont(name: "Roboto-Regular", size: 17))
            .foregroundColor(Colors.primary)
            .clearButtonMode(.whileEditing)
            .roundedBorderModifier(color: isEditing ? Colors.primary : Colors.neutral)
    }
    
    private func updateTextWithPrefix() {
        if text.count <= 1 {
            DispatchQueue.main.async {
                self.text = "+"
            }
        }
    }
    
}
