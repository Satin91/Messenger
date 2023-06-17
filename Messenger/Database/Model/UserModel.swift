//
//  UserModel.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import RealmSwift

@objcMembers
class UserModel: Object, Codable {
    dynamic var id: Int = 0
    dynamic var refreshToken: String?
    dynamic var accessToken: String?
    // authinfo
    
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var username = ""
    //registrationInfo
    
    dynamic var birthday: String?
    dynamic var city: String?
    dynamic var avatar: String?
    dynamic var avatarData: Data?
    dynamic var avatars: Avatars?
    dynamic var zodiacSign: String?
    dynamic var aboutMe: String?
    //userInfo
    
    override static func primaryKey() -> String? {
        "id"
    }
}

@objcMembers class Avatar: Object, Codable {
    dynamic var avatar: String
    dynamic var bigAvatar: String
    dynamic var miniAvatar: String
}
