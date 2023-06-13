//
//  RegisterResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation

struct RegisterResponse: Codable {
    var refresh_token: String
    var access_token: String
    var user_id: Int
}
