//
//  CheckAuthCodeRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import Foundation

struct CheckAuthCodeRequest: NetworkRequestProtocol {
    var parameters: [String: Any]
    
    init(phone: String, code: String) {
        self.parameters = ["phone": phone, "code": code]
    }
    
    func make() -> RequestModel {
        RequestModel(path: Constants.API.checkAuthCodePath, parameters: self.parameters, method: .post)
    }
}
