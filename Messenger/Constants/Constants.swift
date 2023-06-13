//
//  Constants.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation
import SwiftUI

enum Constants {
    enum API {
        static let baseHeaders = ["Content-Type": "application/json", "application/json": "accept"]
        static let baseURL = "https://plannerok.ru/api/v1/"
        static let sendAuthCodePath = "users/send-auth-code/"
        static let checkAuthCodePath = "users/check-auth-code/"
        static let userRegisterPath = "users/register/"
        static let getCurrentUserPath = "users/me/"
    }
}

enum Spacing {
    static let horizontalEdges: CGFloat = 24
    static let extraSmallPadding: CGFloat = 8
    static let smallPadding: CGFloat = 16
    static let mediumPadding: CGFloat = 24
    static let largePadding: CGFloat = 40
    static let smallControl: CGFloat = 36
    static let mediumControl: CGFloat = 57
    
    static let smallRadius: CGFloat = 8
    static let defaultRadius: CGFloat = 16
}

enum Colors {
    static let background = Color("background")
    static let dark = Color("dark")
    static let light = Color("light")
    static let neutral = Color("neutral")
    static let neutralSecondary = Color("neutralSecondary")
    static let primary = Color("primary")
    static let primarySecondary = Color("primarySecondary")
}

enum Images {
    static let verifySuccess = Image("verifySuccess")
}
