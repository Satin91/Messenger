//
//  GlassBackgroundModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 10.07.2023.
//

import Foundation
import SwiftUI

struct GlassBackgroundModifier: ViewModifier {
    var radius: CGFloat
    
    let gradient = LinearGradient(colors: [.white, Color(hex: "452A7C").opacity(0.4)], startPoint: .top, endPoint: .bottomTrailing)
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(.white, lineWidth: 1)
                    .blendMode(.overlay)
                    .offset(x: 0.5, y: 0.5)
                    .blur(radius: 0)
                    .mask {
                        RoundedRectangle(cornerRadius: radius)
                    }
            )
            .backgroundBlur(radius: 40, opaque: true)
            .background(Color.white.opacity(0.4))
            .clipShape(
                RoundedRectangle(cornerRadius: radius)
            )
    }
}

extension View {
    func glassBackground(radius: CGFloat) -> some View {
        modifier(GlassBackgroundModifier(radius: radius))
    }
}
