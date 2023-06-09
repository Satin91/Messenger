//
//  SendAuthCode.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation


struct SendAuthCodeRequest: BaseNetworkRequestProtocol {
    var path: String
    var url: String
    var httpBody: Data?
    var httpMethod: HTTPMethod?
    
    init(phone: String) {
        self.path = Constants.API.sendAuthCodePath
        self.url = Constants.API.baseURL
        let body = ["phone": phone]
        let data = try? JSONSerialization.data(withJSONObject: body)
        self.httpBody = data
        self.httpMethod = .post
    }
}

