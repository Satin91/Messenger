//
//  TitledTextField.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI

struct TitledTextField: View {
    @State var title: String
    @State var placeholder: String
    
    @Binding var text: String
    
    var isDisabled: Bool = false
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Spacing.extraSmallPadding) {
            titleLabel
            textField
        }
    }
    
    var titleLabel: some View {
        Text(title)
            .font(Fonts.roboto(weight: .bold, size: 14))
            .padding(.leading)
        
    }
    
    var textField: some View {
        TextField(placeholder, text: $text)
            .font(Fonts.roboto(weight: .medium, size: 14))
            .foregroundColor(Colors.primary)
            .disabled(isDisabled)
            .padding(.all)
            .padding(.leading)
            .background(Colors.lightGray)
            .cornerRadius(Spacing.smallRadius)
    }
}

struct TitledTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitledTextField(title: "Title", placeholder: "Text", text: .constant("Text"))
    }
}
