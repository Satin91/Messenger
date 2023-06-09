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
    func sendAuthCode(phone: String) -> Future<SendAuthCodeResponse, NetworkError> {
        let request = SendAuthCodeRequest(phone: phone).make
        
        return Future { promise in
            BaseNetworkTask.execute(model: SendAuthCodeResponse.self, request: request)
                .sink { error in
                    switch error {
                    case .failure(_):
                        promise(.failure(NetworkError.noNetworkConnection))
                    default:
                        break
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancelBag)
        }
    }
}


