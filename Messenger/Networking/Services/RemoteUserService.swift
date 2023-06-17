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

    func getCurrentUser(accessToken: String) -> AnyPublisher<GetCurrentUserResponse, Error> {
        let request = GetCurrentUserRequest(accessToken: accessToken)
        return networkManager.sendRequest(request: request)
            .decode(type: GetCurrentUserResponse.self, decoder: JSONDecoder())
            .flatMap { userResponse in
                return self.loadAvatarTo(userResponse)
            }
            .eraseToAnyPublisher()
    }
    
    func updateUser(accessToken: String, user: UserModel, avatar: [String: String]) -> AnyPublisher<UpdateUserResponse, Error> {
        let request = UpdateUserRequest(accessToken: user.accessToken!, name: user.name, username: user.username, birthday: user.birthday, city: user.city, avatar: avatar)
        return networkManager.sendRequest(request: request)
            .decode(type: UpdateUserResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loadAvatarTo(_ userResponse: GetCurrentUserResponse) -> AnyPublisher<GetCurrentUserResponse, Error> {
        guard let address = userResponse.profile_data.avatar else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        guard let url = URL(string: Constants.API.Media.avatar(size: .bigAvatar, address: address)) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ response in
                let temp = userResponse
                temp.profile_data.avatarData = response.data
                return temp
            })
            .mapError { _ in URLError(.badURL) }
            .eraseToAnyPublisher()
    }
}

