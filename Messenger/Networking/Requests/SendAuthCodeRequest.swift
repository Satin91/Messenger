//
//  SendAuthCodeRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation

struct SendAuthCodeRequest: NetworkRequestProtocol {
    var parameters: [String: Any]
    
    init(phone: String) {
        self.parameters = ["phone": phone]
    }
    
    func make() -> RequestModel {
        RequestModel(path: Constants.API.sendAuthCodePath, parameters: self.parameters, method: .post)
    }
}
