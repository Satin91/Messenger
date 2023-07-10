//
//  ChatDatabaseService.swift
//  Messenger
//
//  Created by Артур Кулик on 10.07.2023.
//

import Foundation

protocol ChatDatabaseServiceProtocol {
    func save(message: MessageModel, for companion: CompanionModel)
    func add(companion: CompanionModel, for user: UserModel)
}

final class ChatDatabaseService: ChatDatabaseServiceProtocol {
    
    var databaseManager: DatabaseManagerProtocol
    
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func save(message: MessageModel, for companion: CompanionModel) {
        databaseManager.writeTransaction {
            companion.messages.append(message)
        }
    }
    
    func add(companion: CompanionModel, for user: UserModel) {
        databaseManager.writeTransaction {
            user.companions.append(companion)
        }
    }
}
