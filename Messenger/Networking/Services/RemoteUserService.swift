//
//  RemoteUserService.swift
//  Messenger
//
//  Created by Артур Кулик on 13.06.2023.
//

import Combine
import Foundation

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
            .map({ userresponse -> GetCurrentUserResponse in
                let imageData = try! Data(contentsOf: URL(string: Constants.API.baseURL + userresponse.profile_data.avatars.avatar)! as URL)
                var profileData = userresponse.profile_data
                profileData.avatarData = imageData
                return GetCurrentUserResponse(profile_data: profileData)
            })
            .eraseToAnyPublisher()
    }
    
    func updateUser(accessToken: String, user: UserModel, avatar: [String: String]) -> AnyPublisher<UpdateUserResponse, Error> {
        let request = UpdateUserRequest(accessToken: user.accessToken!, name: user.name, username: user.username, birthday: user.birthday, city: user.city, avatar: avatar)
        return networkManager.sendRequest(request: request)
            .decode(type: UpdateUserResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
