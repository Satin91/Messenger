//
//  DatabaseService.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation

protocol UserDatabaseServiceProtocol {
    func updateUser(execute: () -> Void)
    func save(user: UserModel)
    func getCurrentUser() -> UserModel?
    func setCurrentUser(user: UserModel)
    func removeCurrentUser()
}

final class UserDatabaseService: UserDatabaseServiceProtocol {
    
    var databaseManager: DatabaseManagerProtocol
    
    init(databaseManager: DatabaseManagerProtocol) {
        self.databaseManager = databaseManager
    }
    
    func updateUser(execute: () -> Void) {
        databaseManager.writeTransaction(execute: execute)
    }
    
    func save(user: UserModel) {
        databaseManager.save(object: user)
    }
    
    func getCurrentUser() -> UserModel? {
        databaseManager.fetch(type: CurrentUserModel.self).first?.user
    }
    
    func setCurrentUser(user: UserModel) {
        let currentUser = CurrentUserModel()
        currentUser.user = user
        databaseManager.save(object: currentUser)
    }
    
    func removeCurrentUser() {
        databaseManager.deleteAll(of: CurrentUserModel.self)
    }
}

