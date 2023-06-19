//
//  SpecifyTextFilter.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import SwiftUI
import Combine

enum SyntaxFilterType: String {
    case numbersOnly = "0123456789"
    case URIGeneric = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"
}

struct TextFilterModifier: ViewModifier {
    
    @Binding var text: String
    
    var syntax: SyntaxFilterType
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(text)) { input in
                let filtered = input.filter { syntax.rawValue.contains($0) }
                    if filtered != input {
                        self.text = filtered
                    }
                }
    }
}

extension View {
    func textFilterModifier(text: Binding<String>, syntax: SyntaxFilterType) -> some View {
        modifier(TextFilterModifier(text: text, syntax: .URIGeneric))
    }
}
