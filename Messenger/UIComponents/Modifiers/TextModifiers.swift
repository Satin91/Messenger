//
//  LargeTitleModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct SmalTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.museoSans(weight: .regular, size: 18))
            .foregroundColor(Colors.dark)
    }
}

extension View {
    func smalTitleModifier() -> some View {
        modifier(SmalTitleModifier())
    }
}

struct MediumTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Fonts.museoSans(weight: .medium, size: 26))
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
            .font(Fonts.museoSans(weight: .bold, size: 40))
            .foregroundColor(Colors.dark)
    }
}

extension Text {
    func largeTitleModifier() -> some View {
        modifier(LargeTitleModifier())
    }
}

struct PrimaryTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Fonts.museoSans(weight: .medium, size: 14))
            .foregroundColor(Colors.primary)
    }
}

extension View {
    func primaryTextModifier() -> some View {
        modifier(PrimaryTextModifier())
    }
}
