//
//  NetworkService.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import Foundation
import Combine
import UIKit

class NetworkService {
    var cancelBag = Set<AnyCancellable>()
    
    func sendAuthCode(phone: String) -> AnyPublisher<SendAuthCodeResponse, Error> {
        let request = SendAuthCodeRequest(phone: phone)
        return BaseNetworkTask.sharedInstance.execute(request: request)
            .decode(type: SendAuthCodeResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


