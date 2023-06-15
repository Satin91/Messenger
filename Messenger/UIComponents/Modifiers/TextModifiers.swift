//
//  LargeTitleModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct MediumTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Fonts.roboto(weight: .medium, size: 26))
            .foregroundColor(Colors.dark)
    }
}

extension Text {
    func mediumTitleModifier() -> some View {
        modifier(MediumTitleModifier())
    }
}


struct LargeTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Fonts.roboto(weight: .bold, size: 40))
            .foregroundColor(Colors.dark)
    }
}

extension Text {
    func largeTitleModifier() -> some View {
        modifier(LargeTitleModifier())
    }
}
