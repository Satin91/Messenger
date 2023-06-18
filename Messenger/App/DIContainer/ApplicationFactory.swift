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
    
    var databaseService: DatabaseServiceProtocol{
        DatabaseService(databaseManager: databaseManager)
    }
    
    var authService: AuthentificationServiceProtocol {
        AuthentificationService(networkManager: networkManager)
    }
    
    var remoteUserService: RemoteUserServiceProtocol {
        RemoteUserService(networkManager: networkManager)
    }
    
    var verificationScreenViewModel: AuthenticationScreenViewModel {
        AuthenticationScreenViewModel(authService: authService, databaseService: databaseService, notificationService: notificationService, remoteUserService: remoteUserService)
    }
    
    func profileScreenViewModel(user: UserModel) -> ProfileScreenViewModel {
        ProfileScreenViewModel(databaseService: databaseService, remoteUserService: remoteUserService, user: user)
    }
    
    func chatListScreenViewModel(user: UserModel) -> ChatListScreenViewModel {
        ChatListScreenViewModel(user: user)
    }
    
    init() {
        self.networkManager = NetworkManager(session: Session.default)
        self.databaseManager = DatabaseManager()
        self.notificationManager = NotificationManager()
    }
}
