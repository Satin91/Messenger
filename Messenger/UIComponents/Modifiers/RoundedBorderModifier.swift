//
//  RoundedBorderModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct RoundedBorderModifier: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Colors.light)
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(color, lineWidth: 1)
                }
            )
    }
}

extension View {
    func roundedBorderModifier(color: Color) -> some View {
        modifier(RoundedBorderModifier(color: color))
    }
}
