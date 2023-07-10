//
//  GetCurrentUserRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Alamofire
import Foundation

struct GetCurrentUserRequest: NetworkRequestProtocol {
    var header: [String: String]
    
    init(accessToken: String) {
        self.header = ["Authorization": "Bearer \(accessToken)"]
    }
    
    func make() -> RequestModel {
        let headers = header.merging(Constants.API.baseHeaders) { $1 }
        return RequestModel(path: Constants.API.baseURL + Constants.API.User.getCurrentUserPath, headers: HTTPHeaders(headers), method: .get)
    }
}
