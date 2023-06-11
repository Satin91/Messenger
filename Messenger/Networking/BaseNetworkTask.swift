//
//  BaseNetworkTask.swift
//  Messenger
//
//  Created by Артур Кулик on 10.06.2023.
//

import Alamofire
import Combine
import Foundation

class BaseNetworkTask {
    static let sharedInstance = BaseNetworkTask()
    private let session: Session
    
    init() {
        self.session = Session.default
    }
    
    func execute(request: BaseNetworkRequestProtocol) -> AnyPublisher<Data, Error> {
        let request = request.make()
        return session.request(request.baseUrl + request.path, method: .post, parameters: request.parameters, encoding: request.encoding, headers: request.headers).publishData()
            .tryMap { response -> Data in
                switch response.result {
                case .success(let data):
                    let serialize = try! JSONSerialization.jsonObject(with: data)
                    print("Response data \(serialize)")
                    return data
                case .failure(let error):
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
