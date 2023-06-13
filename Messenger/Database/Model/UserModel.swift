//
//  UserModel.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import RealmSwift

@objcMembers
class UserModel: Object {
    dynamic var user_id: String
    dynamic var name: String
    dynamic var username: String
    dynamic var birthday: String
    dynamic var city: String
    dynamic var avatars: Avatar
    dynamic var zodiacSign: String
    
    
}

@objcMembers class Avatar: Object, Codable {
    dynamic var avatar: String
    dynamic var bigAvatar: String
    dynamic var miniAvatar: String
}
//Должен содержать аватарку пользователя, номер телефона, никнейм, город проживания, дату рождения, знак зодиака по дате рождения, о себе.


//{
//  "profile_data": {
//    "name": "string",
//    "username": "string",
//    "birthday": "2023-06-13",
//    "city": "string",
//    "vk": "string",
//    "instagram": "string",
//    "status": "string",
//    "avatar": "string",
//    "id": 0,
//    "last": "2023-06-13T18:58:32.138Z",
//    "online": true,
//    "created": "2023-06-13T18:58:32.138Z",
//    "phone": "string",
//    "completed_task": 0,
//    "avatars": {
//      "avatar": "string",
//      "bigAvatar": "string",
//      "miniAvatar": "string"
//    }
//  }
//}
