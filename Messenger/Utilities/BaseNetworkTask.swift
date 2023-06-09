//
//  BaseNetworkTask.swift
//  Messenger
//
//  Created by Артур Кулик on 10.06.2023.
//

import Combine
import Foundation

enum BaseNetworkTask {
    static func execute<T: Decodable>(model: T.Type, request: URLRequest) -> AnyPublisher<T, Error> {
        guard request.url != nil else {
            return Fail(outputType: model, failure: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.DataTaskPublisher(request: request, session: URLSession.shared)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.networkConnectionLost)
                }
                return element.data
            }
            .decode(type: model.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
