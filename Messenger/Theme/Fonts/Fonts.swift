//
//  Fonts.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import SwiftUI

enum Fonts: String {
    case light = "Roboto-Light"
    case regular = "Roboto-Regular"
    case medium = "Roboto-Medium"
    case bold = "Roboto-Bold"
    
    static func roboto(weight: Fonts, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
}
