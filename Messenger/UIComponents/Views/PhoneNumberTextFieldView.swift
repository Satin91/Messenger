//
//  PhoneNumberTextFieldView.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI
import iPhoneNumberField

struct PhoneNumberTextFieldView: View {
    
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
            .countryCodePlaceholderColor(Colors.neutralSecondary)
            .flagHidden(false)
            .maximumDigits(12)
            .defaultRegion("DE")
            .font(UIFont(name: "Roboto-Regular", size: 17))
            .foregroundColor(Colors.primary)
            .clearButtonMode(.whileEditing)
            .padding(Spacing.smallPadding)
            .modifier(RoundedBorderModifier(color: isEditing ? Colors.primary : Colors.neutral))
         
    }
}
