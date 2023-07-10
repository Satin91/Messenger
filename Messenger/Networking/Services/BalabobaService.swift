//
//  BalabobaService.swift
//  Messenger
//
//  Created by Артур Кулик on 09.07.2023.
//

import Foundation
import Combine

protocol BalabobaServiceProtocol {
    func send(message: String) -> AnyPublisher<BalabobaDecodingData, Error>
}

class BalabobaService: BalabobaServiceProtocol {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func send(message: String) -> AnyPublisher<BalabobaDecodingData, Error> {
        let request = BalabobaMessageRequest(query: message)
        return networkManager.sendRequest(request: request)
            .decode(type: BalabobaDecodingData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct BalabobaDecodingData: Decodable {
    var text: String
}
