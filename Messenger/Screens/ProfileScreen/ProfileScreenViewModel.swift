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
    var databaseService: DatabaseServiceProtocol
    
    
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
    
    init(databaseService: DatabaseServiceProtocol, remoteUserService: RemoteUserServiceProtocol, user: UserModel) {
        self.remoteUserService = remoteUserService
        self.databaseService = databaseService
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
    
    ///обновление пользователя в базе и на сервере.
    func updateUser() {
    
//
        databaseService.updateUser { [weak self] in
            self?.user.name = name
            self?.user.city = city
            self?.user.birthday = birthday?.toString
            self?.user.aboutMe = aboutMe
            self?.user.avatarData = avatar
        }
        
        let base64String = avatar?.base64image
        
        
        let _ = remoteUserService.updateUser(accessToken: user.accessToken ?? "", user: user, avatar: ["filename": "MainAvatar", "base_64": base64String ?? ""])
            .sink { completion in
                let error = completion.error
                if error != nil {
                    print(error?.localizedDescription)
                    print("Cant convert image")
                }
            } receiveValue: { response in
                print(response)
            }
            .store(in: &subscriber)
    }
    
    func removeCurrentUser() {
        databaseService.removeCurrentUser()
    }
}

extension ProfileScreenViewModel: Equatable {
    static func == (lhs: ProfileScreenViewModel, rhs: ProfileScreenViewModel) -> Bool {
        return lhs.name > rhs.name
    }
}
