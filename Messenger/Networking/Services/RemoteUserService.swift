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
    func getUserAvatar(path: String) async -> Data? 
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
            .eraseToAnyPublisher()
    }
    
    func updateUser(accessToken: String, user: UserModel, avatar: [String: String]) -> AnyPublisher<UpdateUserResponse, Error> {
        let request = UpdateUserRequest(accessToken: user.accessToken!, name: user.name, username: user.username, birthday: user.birthday, city: user.city, avatar: avatar)
        return networkManager.sendRequest(request: request)
            .decode(type: UpdateUserResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getUserAvatar(path: String) async -> Data? {
        var endPoint = path
        if !path.hasSuffix("media/") {
            endPoint.insert(contentsOf: "media/avatars/600x600/", at: endPoint.startIndex)
        }
        let urlsString = Constants.API.baseURL + endPoint
        print("Debug: endpoint \(urlsString)")
        do {
            return try await networkManager.dataFromURL(urlString: urlsString)
        } catch let error {
            print("Load image data error \(error.localizedDescription)")
            return nil
        }
    }
    
}
