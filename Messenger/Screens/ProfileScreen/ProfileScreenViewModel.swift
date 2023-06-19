//
//  ProfileScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import Foundation
import SwiftUI
import Combine
import RealmSwift
import UIKit

final class ProfileScreenViewModel: ObservableObject {
    var user: UserModel
    var subscriber = Set<AnyCancellable>()
    var remoteUserService: RemoteUserServiceProtocol
    var userDatabaseService: UserDatabaseServiceProtocol
    var authService: AuthentificationServiceProtocol
    
    /// При каждом изменении @Published свойства, обновляется вся модель. По этому нет причин не использовать вычисляемые свойства, основанне на издателе.
    var zodiacSignText: String? {
        birthday?.zodiac
    }
    
    /// Свойства пользователя, допустимые для модификации.
    @Published var name: String
    @Published var city: String?
    @Published var aboutMe: String?
    @Published var birthday: Date?
    @Published var avatar: Data?
    
    init(databaseService: UserDatabaseServiceProtocol, remoteUserService: RemoteUserServiceProtocol, authService: AuthentificationServiceProtocol, user: UserModel) {
        self.remoteUserService = remoteUserService
        self.userDatabaseService = databaseService
        self.authService = authService
        self.user = user
        self.city = user.city
        self.name = user.name
        self.aboutMe = user.aboutMe
        self.birthday = user.birthday?.toDate
        self.avatar = user.avatarData
    }
    
    /// Проверка на изменения свойств
    func compareChanges() -> Bool {
        guard user.name == self.name else {
            return true
        }
        
        guard user.birthday?.toDate == self.birthday else {
            return true
        }
        
        guard user.city == self.city else {
            return true
        }
        
        guard user.avatarData == self.avatar else {
            return true
        }
        
        guard user.aboutMe == self.aboutMe else {
            return true
        }
        return false
    }
    
    /// Обновление пользователя в базе и на сервере.
    /// В случае ошибки стоит 3 попытки отправить данные на сервер, в противном случае сохранения не произойдет.
    /// В реальном проекте хорошей практикой будет указать свойство "requiredRemoteUserUpdate" и, при устранении ошибки, отправить данные.

    func updateUser(completionHandler: @escaping (Bool) -> Void) {
        authService.refreshToken(refreshToken: user.refreshToken!)
            .retry(3)
            .flatMap { [self] response in
                self.updateLocalUser(response: response)
                return self.updateRemoteuser(response: response)
            }.sink { completiom in
                let error = completiom.error
                if error != nil {
                    completionHandler(false)
                }
            } receiveValue: { _ in
                completionHandler(true)
            }
            .store(in: &subscriber)

    }
    
    private func updateRemoteuser(response: RefreshTokenResponse) -> AnyPublisher<UpdateUserResponse, Error> {
        self.remoteUserService.updateUser(
            accessToken: response.access_token,
            user: self.user,
            avatar: [
                "filename": "MainAvatar",
                "base_64": avatar?.base64image ?? ""
            ]
        )
    }
    
    private func updateLocalUser(response: RefreshTokenResponse) {
        userDatabaseService.updateUser { [weak self] in
            self?.user.refreshToken = response.refresh_token
            self?.user.accessToken = response.access_token
            self?.user.name = name
            self?.user.city = city
            self?.user.birthday = birthday?.toString
            self?.user.aboutMe = aboutMe
            self?.user.avatarData = avatar
        }
    }
    
    
    // MARK: Выход из сессии
    func logOut() {
        userDatabaseService.removeCurrentUser()
    }
    
}

extension ProfileScreenViewModel: Equatable {
    static func == (lhs: ProfileScreenViewModel, rhs: ProfileScreenViewModel) -> Bool {
        return lhs.name > rhs.name
    }
}
