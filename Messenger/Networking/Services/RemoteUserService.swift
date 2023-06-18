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
    
    private func loadAvatarTo(_ userResponse: GetCurrentUserResponse) -> AnyPublisher<GetCurrentUserResponse, Error> {
        guard let address = userResponse.profile_data.avatar else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        let urlString = Constants.API.Media.avatar(size: .bigAvatar, address: address)
        
        return networkManager.dataFromURL(urlString: urlString)
            .map({ data in
                let temp = userResponse
                temp.profile_data.avatarData = data
                return temp
            })
            .mapError { _ in URLError(.badURL) }
            .eraseToAnyPublisher()
    }
}

