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
    var subscriber = Set<AnyCancellable>()
    
    @Published var companion: MockChats.ChatUser
    @Published var messages: [String] = []
    
    init(user: UserModel, companion: MockChats.ChatUser, balabobaService: BalabobaServiceProtocol) {
        self.user = user
        self.companion = companion
        self.balabobaService = balabobaService
    }
    
    func send(message: String) {
        balabobaService.send(message: message)
            .sink { completion in
            } receiveValue: { response in
                print("Response text \(response.text)")
                self.companion.messages.append(response.text)
                self.messages.append(response.text)
            }
            .store(in: &subscriber)
    }
}
