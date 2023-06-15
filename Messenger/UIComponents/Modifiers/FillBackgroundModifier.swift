//
//  FillBackgroundModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI

struct FillBackgroundModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                color
            )
    }
}

extension View {
    func fillBackgroundModifier(color: Color) -> some View {
        modifier(FillBackgroundModifier(color: color))
    }
}
