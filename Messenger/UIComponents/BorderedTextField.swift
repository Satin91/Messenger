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
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Colors.neutral, lineWidth: 1)
                    .frame(height: Spacing.mediumControl)
            )
    }
}

struct BorderedTextField_Previews: PreviewProvider {
    static var previews: some View {
        BorderedTextField(text: .constant("Text"))
    }
}
