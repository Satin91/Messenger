//
//  ChatScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import SwiftUI

final class ChatScreenViewModel: ObservableObject {
    
    var user: UserModel
    @Published var companion: MockChats.ChatUser
    @Published var messages: [String] = []
    
    init(user: UserModel, companion: MockChats.ChatUser) {
        self.user = user
        self.companion = companion
    }
}
