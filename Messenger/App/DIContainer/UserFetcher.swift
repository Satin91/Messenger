//
//  UserFactory.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Foundation

/// Действия этого объекта запускаются при открытии приложения: загрузка пользователя, фильтрация, модификация должна происходить здесь.

final class UserFetcher {
    var applicationFactory: ApplicationFactory
    
    init(applicationFactory: ApplicationFactory) {
        self.applicationFactory = applicationFactory
    }
    
    func fetchCurrentUser() -> UserModel? {
        applicationFactory.databaseService.getCurrentUser()
    }
}
