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
    private let notificationManager: NotificationManagerProtocol
    
    
    var notificationService: NotificationServiceProtocol {
        NotificationService(manager: notificationManager)
    }
    
    var authService: AuthentificationServiceProtocol {
        AuthentificationService(networkManager: networkManager)
    }
    
    // ViewModels
    var verificationScreenViewModel: VerificationScreenViewModel {
        VerificationScreenViewModel(authService: authService, notificationService: notificationService)
    }
    
    
    init() {
        self.networkManager = NetworkManager(session: Session.default)
        self.notificationManager = NotificationManager()
    }
}
