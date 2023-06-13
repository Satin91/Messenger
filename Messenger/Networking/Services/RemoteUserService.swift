//
//  RemoteUserService.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Combine
import Foundation

protocol RemoteUserServiceProtocol {
    func getCurrentUser(accessToken: String) -> AnyPublisher<GetCurrentUserResponse, Error>
}

final class RemoteUserService: RemoteUserServiceProtocol {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCurrentUser(accessToken: String) -> AnyPublisher<GetCurrentUserResponse, Error> {
        let request = GetCurrentUserRequest(accessToken: accessToken)
        return networkManager.sendRequest(request: request)
            .decode(type: GetCurrentUserResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
