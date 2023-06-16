//
//  PopUpModifier.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import SwiftUI


public struct Popup<PopupContent>: ViewModifier where PopupContent: View {
    @Binding var isPresented: Bool
    var view: () -> PopupContent
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
                    view()
                }
            }
    }
    
    init(isPresented: Binding<Bool>,
         view: @escaping () -> PopupContent) {
        self._isPresented = isPresented
        self.view = view
    }
}

extension View {
    
    public func popup<PopupContent: View>(
        isPresented: Binding<Bool>,
        view: @escaping () -> PopupContent) -> some View {
            self.modifier(
                Popup(
                    isPresented: isPresented,
                    view: view)
            )
        }
}
