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
    dynamic var messages = RealmSwift.List<MessageModel>()
    
    convenience init(name: String) {
        self.init()
        self.name = name
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
