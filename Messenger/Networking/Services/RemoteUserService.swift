//
//  RemoteUserService.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Combine
import Foundation
import UIKit

protocol RemoteUserServiceProtocol {
    func getCurrentUser(accessToken: String) -> AnyPublisher<GetCurrentUserResponse, Error>
    func updateUser(accessToken: String, user: UserModel, avatar: [String: String]) -> AnyPublisher<UpdateUserResponse, Error>
}

final class RemoteUserService: RemoteUserServiceProtocol {
    var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    var cancelBag = Set<AnyCancellable>()
    func getCurrentUser(accessToken: String) -> AnyPublisher<GetCurrentUserResponse, Error> {
        let request = GetCurrentUserRequest(accessToken: accessToken)
        return networkManager.sendRequest(request: request)
            .decode(type: GetCurrentUserResponse.self, decoder: JSONDecoder())
            .flatMap { response in
                return self.loadAvatar(userResponse: response)
            }
            .eraseToAnyPublisher()
    }
    
    func updateUser(accessToken: String, user: UserModel, avatar: [String: String]) -> AnyPublisher<UpdateUserResponse, Error> {
        let request = UpdateUserRequest(accessToken: user.accessToken!, name: user.name, username: user.username, birthday: user.birthday, city: user.city, avatar: avatar)
        return networkManager.sendRequest(request: request)
            .decode(type: UpdateUserResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadAvatar(userResponse: GetCurrentUserResponse) -> AnyPublisher<GetCurrentUserResponse, Error> {
        guard var endPoint = userResponse.profile_data.avatar else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        endPoint.insert(contentsOf: "media/avatars/600x600/", at: endPoint.startIndex)
        return URLSession.shared.dataTaskPublisher(for: URL(string: Constants.API.baseURL + endPoint)!)
            .map({ response in
                var userResponse = userResponse
                userResponse.profile_data.avatarData = response.data
                return userResponse
            })
            .mapError({ urlerrir in
                return URLError(.badURL)
            })
            .eraseToAnyPublisher()
    }
}

