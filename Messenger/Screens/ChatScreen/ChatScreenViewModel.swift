//
//  ChatScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import SwiftUI
import Combine

final class ChatScreenViewModel: ObservableObject {
    
    var user: UserModel
    var balabobaService: BalabobaServiceProtocol
    var chatDatabaseService: ChatDatabaseServiceProtocol
    
    var subscriber = Set<AnyCancellable>()
    
    @Published var companion: CompanionModel
    @Published var messages: [MessageModel] = []
    
    init(user: UserModel, companion: CompanionModel, balabobaService: BalabobaServiceProtocol, chatDatabaseService: ChatDatabaseServiceProtocol) {
        self.user = user
        self.companion = companion
        self.balabobaService = balabobaService
        self.chatDatabaseService = chatDatabaseService
        messages = Array(companion.messages)
    }
    
    func write(text: String) {
        let message = MessageModel(text: text, ownerId: String(user.id))
        messages.append(message)
        chatDatabaseService.save(message: message, for: companion)
        send(message: message.text)
    }
    
    func send(message: String) {
        balabobaService.send(message: message)
            .sink { completion in
            } receiveValue: { response in
                print("Response text \(response.text)")
                var message: MessageModel
                if response.text.isEmpty {
                    message = MessageModel(text: "Не могу ничего сказать по этому поводу", ownerId: self.companion.id)
                } else {
                    message = MessageModel(text: response.text, ownerId: self.companion.id)
                }
                self.chatDatabaseService.save(message: message, for: self.companion)
                self.messages.append(message)
            }
            .store(in: &subscriber)
    }
}
