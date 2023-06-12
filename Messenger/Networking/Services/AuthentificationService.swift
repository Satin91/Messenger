//
//  NetworkService.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import Foundation
import Combine
import UIKit

protocol AuthentificationServiceProtocol {
    func sendAuthCode(phone: String) -> AnyPublisher<SendAuthCodeResponse, Error>
    func checkAuthCode(phone: String, code: String) -> AnyPublisher<CheckAuthCodeResponse, Error>
}

class AuthentificationService: AuthentificationServiceProtocol {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func sendAuthCode(phone: String) -> AnyPublisher<SendAuthCodeResponse, Error> {
        let request = SendAuthCodeRequest(phone: phone)
        return networkManager.sendRequest(request: request)
            .decode(type: SendAuthCodeResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func checkAuthCode(phone: String, code: String) -> AnyPublisher<CheckAuthCodeResponse, Error> {
        let request = CheckAuthCodeRequest(phone: phone, code: code)
        return networkManager.sendRequest(request: request)
            .decode(type: CheckAuthCodeResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


