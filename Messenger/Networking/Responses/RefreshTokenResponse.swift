//
//  RefreshTokenResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import Foundation

struct RefreshTokenResponse: Codable {
    var access_token: String
    var refresh_token: String
}
