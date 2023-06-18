//
//  AuthError.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Foundation

enum AuthError: Error {
    case userIsMissing
    case wrongAuthenticationCode
    
    var localizedDescription: String {
        switch self {
        case .userIsMissing:
            return "Пользователь отсутствует"
        case .wrongAuthenticationCode:
            return "Неправильный код аутентификации"
        }
    }
}
