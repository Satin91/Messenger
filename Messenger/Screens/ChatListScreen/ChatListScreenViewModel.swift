//
//  ChatListViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 17.06.2023.
//

import Foundation
import UIKit

/* Ввиду отсутствия бизнес логики, эта вью модель, по сути, не требуется,
 но если потребуется обрабатывать реальные модели чат листа, она пригодится.
 */
final class ChatListScreenViewModel: ObservableObject {
    var user: UserModel
    @Published var chats: [CompanionModel] = []
    var chatDatabaseService: ChatDatabaseServiceProtocol
    let avatarsNames = ["chatAvatar1","chatAvatar2","chatAvatar3","chatAvatar4","chatAvatar5"]
    let companionNames = ["Иван Разговорников","Василий Собеседников", "Валерий Осведомленный", "Стас Выдумщиков"]
    
    init(user: UserModel, chatDatabaseService: ChatDatabaseServiceProtocol) {
        self.user = user
        self.chatDatabaseService = chatDatabaseService
        refreshChats()
    }
    
    func addCompanion(of type: Int) {
        let newCompaion = CompanionModel(name: companionNames.randomElement()!, type: type, avatar: UIImage(named: avatarsNames.randomElement()!)!.pngData()!)
        
        chatDatabaseService.add(companion: newCompaion, for: user)
        let message = MessageModel(text: "Привет, это первый текст из этого чата!", ownerId: newCompaion.id)
        chatDatabaseService.save(message: message, for: newCompaion)
        refreshChats()
    }
    
    private func refreshChats() {
        chats = Array(user.companions)
    }
}
