//
//  RegisterRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Foundation

struct RegisterRequest: NetworkRequestProtocol {
    var parameters: [String: Any]
    
    init(phone: String, name: String, username: String) {
        self.parameters = ["phone": phone, "name": phone, "username": username]
    }
    
    func make() -> RequestModel {
        RequestModel(path: Constants.API.registerPath, parameters: self.parameters, method: .post)
    }
}
