//
//  MockChats.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import Foundation

class MockChats {
 
    static let chats: [ChatUser] = [
        ChatUser(name: "Пётр", avatar: "chatAvatar1", messages: [Message(text: "Привет!", date: Date())]),
        ChatUser(name: "Владислав", avatar: "chatAvatar2", messages: [Message(text: "Привет, как дела?", date: Date())]),
        ChatUser(name: "Татьяна", avatar: "chatAvatar3", messages: [Message(text: "Завтра пришлю список полезной литературы по вашему запросу.", date: Date())]),
    ]
    
    struct ChatUser {
        var id = UUID()
        var name: String
        var avatar: String
        var messages: [Message]
    }

    struct Message {
        var text: String
        var date: Date
    }
}
