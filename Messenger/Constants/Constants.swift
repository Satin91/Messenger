//
//  Constants.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation
import SwiftUI

enum Constants {
    enum CommonNames {
        static let avatarPlaceholder = "avatarPlaceholder"
    }
    
    enum API {
        static let baseURL = "https://plannerok.ru/"
        
        static let baseHeaders = ["Content-Type": "application/json", "application/json": "accept"]
        enum Auth {
            static let sendAuthCodePath = "api/v1/users/send-auth-code/"
            static let checkAuthCodePath = "api/v1/users/check-auth-code/"
            static let userRegisterPath = "api/v1/users/register/"
        }
        
        enum User {
            static let getCurrentUserPath = "api/v1/users/me/"
            static let updateUserPath = "api/v1/users/me/"
        }
        
        enum Media {
            enum Avatar: String {
                case avatar = "media/ava tars/400x400/"
                case bigAvatar = "media/avatars/600x600/"
                case miniAvatar = "media/avatars/200x200/"
            }
            static func avatar(size: Media.Avatar, address: String) -> String {
                return Constants.API.baseURL + size.rawValue + address
            }
        }
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
    static let largeRadius: CGFloat = 32
}

enum Colors {
    static let background = Color("background")
    static let dark = Color("dark")
    static let light = Color("light")
    static let neutral = Color("neutral")
    static let neutralSecondary = Color("neutralSecondary")
    static let primary = Color("primary")
    static let primarySecondary = Color("primarySecondary")
    static let chatBackground = Color("chatBackground")
    static let darkBlueShadow = Color("darkBlueShadow")
    static let lightGray = Color("lightGray")
}
