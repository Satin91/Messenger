//
//  RegistrationScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation
import Combine

final class RegistrationScreenViewModel: ObservableObject {
    var databaseService: DatabaseServiceProtocol
    var authService: AuthentificationServiceProtocol
    var remoteUserService: RemoteUserServiceProtocol
    
    var subscriber = Set<AnyCancellable>()
    
    let phoneNumber: String
    
    @Published var name: String = ""
    @Published var userName: String = ""
    
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthentificationServiceProtocol, remoteUserService: RemoteUserServiceProtocol, phoneNumber: String) {
        self.databaseService = databaseService
        self.authService = authService
        self.phoneNumber = phoneNumber
        self.remoteUserService = remoteUserService
    }
    
    func register() {
        authService.register(phone: phoneNumber, name: name, username: userName)
            .sink { completion in
                let error = try? completion.error()
                print("Register Error \(error)")
            } receiveValue: { response in
                print("Register Response \(response)")
                self.remoteUserService.getCurrentUser(accessToken: response.access_token)
                    .sink { completion in
                        let error = try? completion.error()
                        print("GetCurrentUser Error \(error)")
                    } receiveValue: { response in
                        print("Current user response \(response)")
                    }
                    .store(in: &self.subscriber)
                
            }
            .store(in: &subscriber)
    }
}
