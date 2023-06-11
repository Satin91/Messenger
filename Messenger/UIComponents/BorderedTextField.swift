//
//  BorderedTextField.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI

struct BorderedTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        content
    }
    
    private var content: some View {
        textField
    }
    
    private var textField: some View {
        TextField("Phone number", text: $text)
            .padding(Spacing.smallPadding)
            .font(Fonts.makeFont(weight: .bold, size: 14))
            .foregroundColor(Colors.dark)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Colors.light)
                        .frame(height: Spacing.mediumControl)
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(Colors.neutral, lineWidth: 1)
                        .frame(height: Spacing.mediumControl)
                }
            )
    }
}

struct BorderedTextField_Previews: PreviewProvider {
    static var previews: some View {
        BorderedTextField(text: .constant("Text"))
    }
}
