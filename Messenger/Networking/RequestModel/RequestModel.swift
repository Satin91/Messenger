//
//  NetworkRequest.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation
import Alamofire

// Протокол, который должны реализовать все объекты запросов.
// Запросы создаются отдельно и инициализируют обязательные свойства
protocol NetworkRequestProtocol {
    func make() -> RequestModel
}

// Headers, baseURL объявлены геттерами для улучшения читаемости. в реальном проекте, они были бы обычными глобальными свойствами.
struct RequestModel {
    var path: String
    var parameters: [String : Any]?
    var httpMethod: Alamofire.HTTPMethod?
    
    var headers: HTTPHeaders {
        HTTPHeaders(Constants.API.baseHeaders)
    }
    var baseUrl: String {
        Constants.API.baseURL
    }
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }
    
    init(path: String, parameters: [String: Any]?, httpMethod: Alamofire.HTTPMethod? = nil) {
        self.path = path
        self.parameters = parameters
        self.httpMethod = httpMethod
    }
}
