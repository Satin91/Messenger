//
//  CheckAuthCodeResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import Foundation

struct CheckAuthCodeResponse: Codable {
    var refresh_token: String?
    var access_token: String?
    var user_id: Int?
    var is_user_exists: Bool
}
