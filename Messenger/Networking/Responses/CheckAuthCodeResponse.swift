//
//  CheckAuthCodeResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import Foundation

enum CheckAuthCodeResponse: Codable {
    case response(AuthCodeResponse)
    case error(ErrorMessage)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let response = try? container.decode(AuthCodeResponse.self)
        let error = try? container.decode(ErrorMessage.self)
        
        switch response {
        case .some(let response):
            self = .response(response)
            return
        default:
            break
        }
        
        switch error {
        case .some(let error):
            self = .error(error)
        default:
            self = .error(ErrorMessage(detail: Detail(message: "Неизвестная ошибка, перезапустите приложение.")))
        }
    }
}

struct AuthCodeResponse: Codable {
    var refresh_token: String?
    var access_token: String?
    var user_id: Int?
    var is_user_exists: Bool
}

struct ErrorMessage: Error, Codable {
    let detail: Detail
}

struct Detail: Codable {
    let message: String
}
