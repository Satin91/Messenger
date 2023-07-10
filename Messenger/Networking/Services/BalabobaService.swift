//
//  BalabobaService.swift
//  Messenger
//
//  Created by Артур Кулик on 09.07.2023.
//

import Foundation
import Combine

class BalabobaService {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func sendMessage(query: String) -> AnyPublisher<BalabobaDecodingData, Error> {
        let request = BalabobaMessageRequest(query: query)
        return networkManager.sendRequest(request: request)
            .decode(type: BalabobaDecodingData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct BalabobaDecodingData: Decodable {
    var text: String
}
