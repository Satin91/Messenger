//
//  ShadowModifiers.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import SwiftUI

struct LargeShadowModifier: ViewModifier {
    
    var radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Colors.darkBlueShadow.opacity(0.1), radius: radius, y: radius)
    }
}

extension View {
    func largeShadowModifier() -> some View {
        modifier(LargeShadowModifier(radius: 15))
    }
    
    func mediumShadowModifier() -> some View {
        modifier(LargeShadowModifier(radius: 8))
    }
    
    func smallShadowModifier() -> some View {
        modifier(LargeShadowModifier(radius: 4))
    }
}
