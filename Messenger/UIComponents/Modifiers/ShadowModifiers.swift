//
//  ShadowModifiers.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import SwiftUI

struct LargeShadowModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Colors.darkBlueShadow.opacity(0.1), radius: 15, y: 15)
    }
}

extension View {
    func largeShadowModifier() -> some View {
        modifier(LargeShadowModifier())
    }
}
