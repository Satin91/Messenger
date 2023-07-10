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
//
//struct ProfileData: Codable {
//    var avatar: String?
//    var avatarData: Data?
//    var avatars: Avatars
//    var birthday: String?
//    var city: String?
//    var completed_task: Int
//    var created: String?
//    var id: Int
//    var instagram: String?
//    var last: String?
//    var name: String
//    var online: Bool?
//    var phone: String
//    var status: String?
//    var username: String
//    var vk: String?
//}
//
struct Avatars: Codable {
    var avatar: String
    var bigAvatar: String
    var miniAvatar: String
}
