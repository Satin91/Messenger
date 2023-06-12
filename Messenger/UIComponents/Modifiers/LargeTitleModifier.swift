//
//  LargeTitleModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct LargeTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Fonts.makeFont(weight: .bold, size: 40))
            .foregroundColor(Colors.dark)
    }
}

extension Text {
    func largeTitleModifier() -> some View {
        modifier(LargeTitleModifier())
    }
}
