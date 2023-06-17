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
    func dataFromURL(urlString: String) async throws -> Data?
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
    
    func dataFromURL(urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
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
