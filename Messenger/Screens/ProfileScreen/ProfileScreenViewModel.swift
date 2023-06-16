//
//  ProfileScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 15.06.2023.
//

import Foundation
import CryptoKit

final class ProfileScreenViewModel: ObservableObject {
    var user: UserModel
    
    /// При каждом изменении @Published свойства, обновляется вся модель. По этому нет причин не использовать вычисляемое свойства, основанне на издателе.
    var zodiacSignText: String? {
        birthday?.zodiac
    }
    
    /// Кнопка сохранения свойств пользователя имеет состояния, этот флаг оповещает об изменениях.
    @Published var isUserChanged = false

    /// Свойства пользователя, допустимые для модификации.
    @Published var name: String
    @Published var city: String?
    @Published var aboutMe = ""
    @Published var birthday: Date?
    
    var remoteUserService: RemoteUserServiceProtocol
    //TODO: implement databaseService
    
    init(remoteUserService: RemoteUserServiceProtocol, user: UserModel) {
        self.remoteUserService = remoteUserService
        self.user = user
        self.city = user.city
        self.name = user.name
        self.aboutMe = user.aboutMe
        self.birthday = user.birthday?.toDate
        print("init")
    }
    
    func calculateZodiac(date: Date) {
        birthday = date
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
        
        guard user.aboutMe == self.aboutMe else {
            return true
        }
        return false
    }
    
    ///обновление пользователя в базе и на сервере.
    func updateUser() {
    }
}

extension ProfileScreenViewModel: Equatable {
    static func == (lhs: ProfileScreenViewModel, rhs: ProfileScreenViewModel) -> Bool {
        return lhs.name > rhs.name
    }
}
