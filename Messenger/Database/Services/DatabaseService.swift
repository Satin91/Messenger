//
//  DatabaseService.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation

protocol DatabaseServiceProtocol {
    func save(user: UserModel)
}

final class DatabaseService: DatabaseServiceProtocol {
    var databaseManager: DatabaseManagerProtocol
    
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func save(user: UserModel) {
        databaseManager.save(object: user)
    }
}

