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
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        .shadow(color: Color.white, radius: 8, x: -8, y: -8)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(Color.clear)
                        .shadow(color: Color.white, radius: 8, x: 8, y: 8)
                        .clipShape(
                            RoundedRectangle(cornerRadius: radius)
                        )
                }
            )
            .background(.thinMaterial)
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
