//
//  UpdateUserRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 16.06.2023.
//

import Foundation
import Alamofire

struct UpdateUserRequest: NetworkRequestProtocol {
    
    var parameters: [String: Any?]
    var header: [String: String]
    
    init(accessToken: String, name: String, username: String, birthday: String?, city: String?, avatar: [String: String]) {
        self.header = ["Authorization": "Bearer \(accessToken)"]
        parameters = [
            "name": name,
            "username": username,
            "birthday": birthday,
            "city": city,
            "avatar": avatar
        ]
    }
    
    func make() -> RequestModel {
        let headers = header.merging(Constants.API.baseHeaders) { $1 }
        return RequestModel(path: Constants.API.updateUserPath, parameters: parameters, headers: HTTPHeaders(headers), method: .put)
    }
}

//{
//  "name": "string",
//  "username": "string",
//  "birthday": "2023-06-16",
//  "city": "string",
//  "vk": "string",
//  "instagram": "string",
//  "status": "string",
//  "avatar": {
//    "filename": "string",
//    "base_64": "string"
//  }
//}
