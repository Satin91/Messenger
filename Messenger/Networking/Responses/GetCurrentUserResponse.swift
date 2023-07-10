//
//  GetCurrentUserResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation

struct GetCurrentUserResponse: Decodable {
    var profile_data: UserModel
}

struct Avatars: Codable {
    var avatar: String
    var bigAvatar: String
    var miniAvatar: String
}
