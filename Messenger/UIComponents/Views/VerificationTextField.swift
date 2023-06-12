//
//  VerificationTextField.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct VerificationTextField: View {
    @Binding var text: String
    @State var size: CGSize = .zero
    var kerning: CGFloat {
        ((size.width - (letterWidth * lettersCount)) / lettersCount)
    }
    
    let letterWidth: CGFloat = 30
    let lettersCount: CGFloat = 6
    
    var body: some View {
        content
    }
    
    var content: some View {
        VStack {
            textField
            dash
        }
        .readSize(in: $size)
    }
    
    var textField: some View {
        TextField("", text: $text)
            .font(Fonts.makeFont(weight: .medium, size: 50))
            .foregroundColor(Colors.dark)
            .kerning(kerning)
            .frame(height: Spacing.mediumControl)
            .padding(.leading, 18)
    }
    
    var dash: some View {
        HStack(spacing: Spacing.extraSmallPadding) {
            ForEach(0..<6) {_ in
                RoundedRectangle(cornerRadius: 2)
                    .fill(Colors.neutral)
                    .frame(height: 2)
            }
        }
        .padding(.horizontal, Spacing.extraSmallPadding)
    }
}

struct VerificationTextField_Previews: PreviewProvider {
    static var previews: some View {
        VerificationTextField(text: .constant("Text"))
    }
}
