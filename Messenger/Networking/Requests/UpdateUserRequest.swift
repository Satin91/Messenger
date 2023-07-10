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
        return RequestModel(path: Constants.API.baseURL + Constants.API.User.updateUserPath, parameters: parameters, headers: HTTPHeaders(headers), method: .post)
    }
}
