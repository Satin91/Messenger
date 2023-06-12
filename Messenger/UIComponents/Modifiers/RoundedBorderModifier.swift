//
//  RoundedBorderModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import SwiftUI

struct RoundedBorderModifier: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Colors.light)
                        .frame(height: Spacing.mediumControl)
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(color, lineWidth: 1)
                        .frame(height: Spacing.mediumControl)
                }
            )
    }
}
