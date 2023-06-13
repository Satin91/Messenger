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
    private let routher: AppCoordinatorViewModel
    
    
    var notificationService: NotificationServiceProtocol {
        NotificationService(manager: notificationManager)
    }
    
    var databaseService: DatabaseServiceProtocol{
        DatabaseService(databaseManager: databaseManager)
    }
    
    var authService: AuthentificationServiceProtocol {
        AuthentificationService(networkManager: networkManager)
    }
    
    var verificationScreenViewModel: AuthentificationScreenViewModel {
        AuthentificationScreenViewModel(authService: authService, notificationService: notificationService)
    }
    
    func registrationScreenViewModel(phoneNumber: String) -> RegistrationScreenViewModel {
        RegistrationScreenViewModel(databaseService: databaseService, authService: authService, phoneNumber: phoneNumber)
    }
    
    init() {
        self.networkManager = NetworkManager(session: Session.default)
        self.databaseManager = DatabaseManager()
        self.notificationManager = NotificationManager()
        self.routher = AppCoordinatorViewModel()
    }
}
