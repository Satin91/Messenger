//
//  PassthroughtBlend.swift
//  Messenger
//
//  Created by Артур Кулик on 12.07.2023.
//

import SwiftUI

struct PassthroughtBlend: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blendMode(.overlay)
            .overlay {
                content
                    .blendMode(.overlay)
            }
            .overlay {
                content
                    .blendMode(.overlay)
            }
    }
}
