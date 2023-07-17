//
//  BalabobaService.swift
//  Messenger
//
//  Created by Артур Кулик on 09.07.2023.
//

import Foundation
import Combine

protocol BalabobaServiceProtocol {
    func send(message: String, type: Int) -> AnyPublisher<BalabobaResponse, Error>
}

class BalabobaService: BalabobaServiceProtocol {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func send(message: String, type: Int) -> AnyPublisher<BalabobaResponse, Error> {
        let request = BalabobaMessageRequest(query: message, intro: type)
        return networkManager.sendRequest(request: request)
            .decode(type: BalabobaResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
