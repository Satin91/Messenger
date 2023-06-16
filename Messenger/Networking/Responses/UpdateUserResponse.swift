//
//  UpdateUserResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 16.06.2023.
//

import Foundation

struct UpdateUserResponse: Codable {
    var avatars: Avatars
}

struct Avatars: Codable {
    var avatar: String
    var bigAvatar: String
    var miniAvatar: String
}
