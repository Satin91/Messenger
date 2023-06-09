//
//  ApplicationFactory.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation
import Alamofire

/*
 В этом файле реализуются все основные протоколы, учавствующие в работе приложения.
 */

final class ApplicationFactory {
    private let networkManager: NetworkManagerProtocol
    private let databaseManager: DatabaseManagerProtocol
    private let notificationManager: NotificationManagerProtocol
    
    var notificationService: NotificationServiceProtocol {
        NotificationService(manager: notificationManager)
    }
    
    var userDatabaseService: UserDatabaseServiceProtocol {
        UserDatabaseService(databaseManager: databaseManager)
    }
    
    var balabobaService: BalabobaServiceProtocol {
        BalabobaService(networkManager: networkManager)
    }
    
    var chatDatabaseService: ChatDatabaseServiceProtocol {
        ChatDatabaseService(databaseManager: databaseManager)
    }
    
    var authService: AuthServiceProtocol {
        AuthService(networkManager: networkManager)
    }
    
    var remoteUserService: RemoteUserServiceProtocol {
        RemoteUserService(networkManager: networkManager)
    }
    
    var verificationScreenViewModel: AuthenticationScreenViewModel {
        AuthenticationScreenViewModel(authService: authService, databaseService: userDatabaseService, notificationService: notificationService, remoteUserService: remoteUserService)
    }
    
    func profileScreenViewModel(user: UserModel) -> ProfileScreenViewModel {
        ProfileScreenViewModel(databaseService: userDatabaseService, remoteUserService: remoteUserService, authService: authService, user: user)
    }
    
    func chatListScreenViewModel(user: UserModel) -> ChatListScreenViewModel {
        ChatListScreenViewModel(user: user, chatDatabaseService: chatDatabaseService)
    }
    
    func chatScreenViewModel(user: UserModel, companion: CompanionModel) -> ChatScreenViewModel {
        ChatScreenViewModel(user: user, companion: companion, balabobaService: balabobaService, chatDatabaseService: chatDatabaseService)
    }
    
    init() {
        self.networkManager = NetworkManager(session: Session.default)
        self.databaseManager = DatabaseManager()
        self.notificationManager = NotificationManager()
    }
}
