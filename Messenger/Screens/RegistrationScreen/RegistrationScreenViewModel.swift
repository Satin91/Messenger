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
    var subscriber = Set<AnyCancellable>()
    
    let phoneNumber: String
    
    @Published var name: String = ""
    @Published var userName: String = ""
    
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthentificationServiceProtocol, phoneNumber: String) {
        self.databaseService = databaseService
        self .authService = authService
        self.phoneNumber = phoneNumber
    }
    
    func register() {
        authService.register(phone: phoneNumber, name: name, username: userName)
            .sink { completion in
                let error = try? completion.error()
                print("Register Error \(error)")
            } receiveValue: { response in
                print("Register Response \(response)")
            }
            .store(in: &subscriber)
    }
}
