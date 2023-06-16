//
//  RoundedBorderModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct RoundedBorderModifier: ViewModifier {
    var borderColor: Color
    var backgroundColor: Color?
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(backgroundColor ?? Colors.light)
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(borderColor, lineWidth: 1)
                }
            )
    }
}

extension View {
    func roundedBorderModifier(borderColor: Color, backgroundColor: Color? = nil) -> some View {
        modifier(RoundedBorderModifier(borderColor: borderColor, backgroundColor: backgroundColor))
    }
}
