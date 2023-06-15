//
//  ApplicationFactory.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation
import Alamofire

/*
 В этом файле реализуются все протоколы, учавствующие в работе приложения
 , имплементируются в SceneFactory.
 */

final class ApplicationFactory {
    private let networkManager: NetworkManagerProtocol
    private let databaseManager: DatabaseManagerProtocol
    private let notificationManager: NotificationManagerProtocol
    let routher: AppCoordinatorViewModel
    
    
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
    
    var profileScreenViewModel: ProfileScreenViewModel {
        ProfileScreenViewModel(remoteUserService: remoteUserService)
    }
    
    init() {
        self.networkManager = NetworkManager(session: Session.default)
        self.databaseManager = DatabaseManager()
        self.notificationManager = NotificationManager()
        self.routher = AppCoordinatorViewModel()
    }
}
