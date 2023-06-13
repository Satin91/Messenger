//
//  GetCurrentUserResponse.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation

struct GetCurrentUserResponse: Codable {
    var profile_data: ProfileData
}

struct ProfileData: Codable {
    var avatar: String
    var avatars: [String]?
    var birthday: String?
    var city: String?
    var completed_task: Int
    var created: String
    var id: Int
    var instagram: String
    var last: String
    var name: String
    var online: Bool
    var phone: String
    var status: String
    var username: String
    var vk: String
}

struct UserAvatar: Codable {
    var avatar: String
    var bigAvatar: String
    var miniAvatar: String
}
//"profile_data" =     {
//    avatar = "<null>";
//    avatars = "<null>";
//    birthday = "<null>";
//    city = "<null>";
//    "completed_task" = 0;
//    created = "2023-06-13T22:34:09+00:00";
//    id = 1379;
//    instagram = "<null>";
//    last = "<null>";
//    name = "+7 8284222421";
//    online = 0;
//    phone = 78284222421;
//    status = "<null>";
//    username = 123aaa234;
//    vk = "<null>";
//};
