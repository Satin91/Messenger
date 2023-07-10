//
//  PopupModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 10.07.2023.
//

import Foundation
import SwiftUI

extension View {
    
}

struct Popup<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool
    let alignment: Alignment
    @State var xOffset: CGFloat = 0
    
    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                popupContent()
            )
            .animation(.spring(), value: isPresented)
    }
    
    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .transition(.offset(x: 0, y: geometry.belowScreenEdge))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
            
        }
    }
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}
