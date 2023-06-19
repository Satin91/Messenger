//
//  RefreshTokenRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 19.06.2023.
//

import Foundation
import Alamofire

struct RefreshTokenRequest: NetworkRequestProtocol {
    var params: [String: String]
    
    init(refreshToken: String) {
        self.params = ["refresh_token": refreshToken]
    }
    
    func make() -> RequestModel {
        return RequestModel(path: Constants.API.Auth.refreshTokenPath,parameters: params, method: .post)
    }
}
