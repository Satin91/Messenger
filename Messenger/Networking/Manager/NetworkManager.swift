//
//  BaseNetworkTask.swift
//  Messenger
//
//  Created by Артур Кулик on 10.06.2023.
//

import Alamofire
import Combine
import Foundation

protocol NetworkManagerProtocol {
    func sendRequest(request: NetworkRequestProtocol) -> AnyPublisher<Data, Error>
    func dataFromURL(urlString: String) -> AnyPublisher<Data, Error>
}

class NetworkManager: NetworkManagerProtocol {
    var session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    func sendRequest(request: NetworkRequestProtocol) -> AnyPublisher<Data, Error> {
        let request = request.make()
        return session.request(request.baseUrl + request.path, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers).publishData()
            .tryMap { response -> Data in
                switch response.result {
                case .success(let data):
                    let serialize = try! JSONSerialization.jsonObject(with: data)
                    print("Response data \(serialize)")
                    return data
                case .failure(let error):
                    print("Response error \(error)")
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
    
    func dataFromURL(urlString: String) -> AnyPublisher<Data, Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return session.request(url).publishData()
            .tryMap { response -> Data in
                switch response.result {
                case .success(let data):
                    let serialize = try! JSONSerialization.jsonObject(with: data)
                    print("Response data \(serialize)")
                    return data
                case .failure(let error):
                    print("Response error \(error)")
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}

extension Subscribers.Completion {
    func error() throws -> Failure {
        if case let .failure(error) = self {
            return error
        }
        throw ErrorFunctionThrowsError.error
    }
    private enum ErrorFunctionThrowsError: Error { case error }
}
