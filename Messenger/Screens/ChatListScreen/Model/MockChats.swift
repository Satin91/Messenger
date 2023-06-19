//
//  MockChats.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import Foundation

class MockChats {
 
    static let chats: [ChatUser] = [
        ChatUser(name: "Пётр", avatar: "chatAvatar1", messages: ["Привет!", "Напоминаю про нашу встречу сегодня вечером :)"]),
        ChatUser(name: "Владислав", avatar: "chatAvatar2", messages: ["Эй! Не знаешь в какой аудитории у нас сегодня философия?", "Сегодня же нашего \"Канта\" заменяют..", "Надеюсь другой препод в курсе что мы сейчас проходим, а то я сильно сильно вчера зубрил."]),
        ChatUser(name: "Татьяна", avatar: "chatAvatar3", messages: ["Завтра пришлю список полезной литературы по вашему запросу."])
    ]
    
    struct ChatUser {
        var id = UUID()
        var name: String
        var avatar: String
        var messages: [String]
    }
}
