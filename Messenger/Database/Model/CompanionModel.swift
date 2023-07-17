//
//  CompanionModel.swift
//  Messenger
//
//  Created by Артур Кулик on 10.07.2023.
//

import Foundation
import RealmSwift

@objcMembers
class CompanionModel: Object, Decodable {
    dynamic var id: String = UUID().uuidString
    dynamic var name: String = ""
    dynamic var type: Int = 0
    dynamic var avatar: Data = Data()
    dynamic var messages = RealmSwift.List<MessageModel>()
    
    convenience init(name: String, type: Int, avatar: Data) {
        self.init()
        self.name = name
        self.type = type
        self.avatar = avatar
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}

@objcMembers
class MessageModel: Object, Decodable {
    dynamic var id: String = UUID().uuidString
    dynamic var ownerId: String = ""
    dynamic var text: String = ""
    dynamic var date: Date = Date()
    
    convenience init(text: String, ownerId: String) {
        self.init()
        self.text = text
        self.ownerId = ownerId
    }
    
    override static func primaryKey() -> String? {
        "id"
    }
}
