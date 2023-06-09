//
//  NetworkRequestModel.swift
//  Messenger
//
//  Created by Артур Кулик on 09.06.2023.
//

import Foundation

protocol BaseNetworkRequestProtocol {
    var path: String { get set }
    var url: String { get set }
    var httpBody: Data? { get set}
    var httpMethod: HTTPMethod? { get set }
}

extension BaseNetworkRequestProtocol {
    var headers: [String: String] {
        get {
            return ["Content-Type": "application/json", "application/json": "accept"]
        }
    }
    
    var make: URLRequest {
        var request = URLRequest(url: URL(string: url + path)!)
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        request.httpMethod = httpMethod?.rawValue
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
