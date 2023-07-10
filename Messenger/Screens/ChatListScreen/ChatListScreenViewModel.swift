//
//  ChatListViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 17.06.2023.
//

import Foundation

/* Ввиду отсутствия бизнес логики, эта вью модель, по сути, не требуется,
 но если потребуется обрабатывать реальные модели чат листа, она пригодится.
 */
final class ChatListScreenViewModel: ObservableObject {
    var user: UserModel
    @Published var chats: [CompanionModel] = []
    var chatDatabaseService: ChatDatabaseServiceProtocol
    
    init(user: UserModel, chatDatabaseService: ChatDatabaseServiceProtocol) {
        self.user = user
        self.chatDatabaseService = chatDatabaseService
        chats = Array(user.companions)
//        addCompanion()
    }
    
    func addCompanion() {
        let newCompaion = CompanionModel(name: "Интересный собеседник")
        chatDatabaseService.add(companion: newCompaion, for: user)
        let message = MessageModel(text: "Привет, это первый текст из этого чата!", ownerId: newCompaion.id)
        chatDatabaseService.save(message: message, for: newCompaion)
    }
}
