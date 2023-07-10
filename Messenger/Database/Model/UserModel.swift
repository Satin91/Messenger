//
//  UserModel.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import RealmSwift

@objcMembers
class UserModel: Object, Decodable {
    dynamic var id: Int = 0
    dynamic var refreshToken: String?
    dynamic var accessToken: String?
    // authinfo
    
    dynamic var name = ""
    dynamic var phone = ""
    dynamic var username = ""
    dynamic var companions: List<CompanionModel>
    //registrationInfo
    
    dynamic var birthday: String?
    dynamic var city: String?
    dynamic var avatar: String?
    dynamic var avatarData: Data?
    dynamic var avatars: Avatars?
    dynamic var zodiacSign: String?
    dynamic var aboutMe: String?
    //userInfo
    
    enum CodingKeys: CodingKey {
        case companions
        case name
        case phone
        case username
        case birthday
        case city
        case avatar
        case avatarData
        case avatars
        case zodiacSign
        case aboutMe
    }
    
    override init() {
        companions = List<CompanionModel>()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.username = try container.decode(String.self, forKey: .username)
        self.birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        self.avatarData = try container.decodeIfPresent(Data.self, forKey: .avatarData)
        self.avatars = try container.decodeIfPresent(Avatars.self, forKey: .avatars)
        self.zodiacSign = try container.decodeIfPresent(String.self, forKey: .companions ) ?? ""
        self.aboutMe = try container.decodeIfPresent(String.self, forKey: .aboutMe)
        self.companions = try container.decodeIfPresent(List<CompanionModel>.self, forKey: .companions ) ?? List<CompanionModel>()
      }
    
    override static func primaryKey() -> String? {
        "id"
    }
}

@objcMembers class Avatar: Object, Codable {
    dynamic var avatar: String
    dynamic var bigAvatar: String
    dynamic var miniAvatar: String
}
