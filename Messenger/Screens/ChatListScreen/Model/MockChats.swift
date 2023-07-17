//
//  MockChats.swift
//  Messenger
//
//  Created by Артур Кулик on 14.06.2023.
//

import Foundation

class MockChats {
    struct ChatUser {
        var id = UUID()
        var name: String
        var avatar: String
        var messages: [String]
    }
}
