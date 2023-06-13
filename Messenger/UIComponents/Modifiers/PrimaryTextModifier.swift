//
//  PrimaryTextModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import SwiftUI

struct PrimaryTextModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Fonts.roboto(weight: .medium, size: 14))
            .foregroundColor(Colors.primary)
    }
}

extension View {
    func primaryTextModifier() -> some View {
        modifier(PrimaryTextModifier())
    }
}
