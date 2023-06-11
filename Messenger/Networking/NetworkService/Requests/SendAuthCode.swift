//
//  SendAuthCode.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation
import Alamofire


struct SendAuthCodeRequest: BaseNetworkRequestProtocol {
    var parameters: [String: Any]
    
    init(phone: String) {
        self.parameters = ["phone" : phone]
    }
    
    func make() -> BaseNetworkRequest {
        BaseNetworkRequest(path: Constants.API.sendAuthCodePath, parameters: self.parameters)
    }
}
