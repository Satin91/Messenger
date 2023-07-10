//
//  TitledTextField.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI

struct TitledTextField: View {
    let title: String
    @Binding var text: String
    
    let placeholder: String
    var axis: Axis = .horizontal
    var isEntryDisabled: Bool = false
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: Layout.Padding.extraSmall) {
            titleLabel
            textField
        }
    }
    
    var titleLabel: some View {
        Text(title)
            .font(Fonts.museoSans(weight: .bold, size: 14))
            .padding(.leading)
        
    }
    
    var textField: some View {
        TextField(placeholder, text: $text, axis: axis)
            .font(Fonts.museoSans(weight: .medium, size: 14))
            .foregroundColor(isEntryDisabled ? Colors.neutral : Colors.primary)
            .disabled(isEntryDisabled)
            .padding(.all)
            .padding(.leading)
            .background(Colors.lightGray)
            .cornerRadius(Layout.Radius.smallRadius)
    }
}

struct TitledTextField_Previews: PreviewProvider {
    static var previews: some View {
        TitledTextField(title: "Title", text: .constant("Text"), placeholder: "Text")
    }
}
