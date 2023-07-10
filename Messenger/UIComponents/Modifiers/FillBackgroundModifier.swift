//
//  FillBackgroundModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI

struct FillBackgroundModifier: ViewModifier {
    var bgView: AnyView
    
    func body(content: Content) -> some View {
        content
            .background(
                bgView
                    .ignoresSafeArea(.all)
            )
    }
}

extension View {
    func fillBackgroundModifier(content: any View) -> some View {
        modifier(FillBackgroundModifier(bgView: AnyView(content)))
    }
}
