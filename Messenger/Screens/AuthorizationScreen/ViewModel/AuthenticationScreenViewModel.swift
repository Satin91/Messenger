//
//  VerificationScreenViewModel.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Combine
import Foundation
import SwiftUI
import UserNotifications
import RealmSwift

final class AuthenticationScreenViewModel: NSObject, ObservableObject {
    var authService: AuthentificationServiceProtocol
    var notificationService: NotificationServiceProtocol
    var remoteUserService: RemoteUserServiceProtocol
    var databaseService: DatabaseServiceProtocol
    
    var subscriber = Set<AnyCancellable>()
    @Published var navigatior: AuthNavigator = .onEnterPhoneNumber
    @Published var phoneNumber = ""
    @Published var verificationCode = ""
    @Published var name = ""
    @Published var username = ""
    @Published var registerSuccess: Bool = false
    
    
    var isFullPhoneNumber: Bool {
        let numbers = Array(phoneNumber).compactMap({ Int(String($0))})
        return numbers.count >= 11
    }
    
    init(authService: AuthentificationServiceProtocol, databaseService: DatabaseServiceProtocol,  notificationService: NotificationServiceProtocol, remoteUserService: RemoteUserServiceProtocol) {
        self.authService = authService
        self.notificationService = notificationService
        self.remoteUserService = remoteUserService
        self.databaseService = databaseService
    }

    func sendAuthCode() {
        authService.sendAuthCode(phone: phoneNumber)
            .sink { completion in
                let error = try? completion.error()
                print("Error \(error)")
            } receiveValue: { response in
                self.sendVerificationCode()
                self.navigatior = .onEnterVerificationCode
            }
            .store(in: &subscriber)
    }
    
    func checkAuthCode() {
        authService.checkAuthCode(phone: phoneNumber, code: verificationCode)
            .sink { completion in
                let error = try? completion.error()
                print("AuthCode Error \(error)")
            } receiveValue: { authResponse in
                if authResponse.is_user_exists {
                    self.remoteUserService.getCurrentUser(accessToken: authResponse.access_token!)
                        .sink { completion in
                            let error = try? completion.error()
                            print("GetCurrentUser Error \(error)")
                        } receiveValue: { userResponse in
                            print("Current user response \(userResponse)")
                            let user = self.saveUserToDB(
                                profileData: userResponse.profile_data,
                                accessToken: authResponse.access_token!,
                                refreshToken: authResponse.refresh_token!
                            )
                            self.databaseService.save(user: user)
                            self.navigatior = .toHomeScreen(user)
                        }
                        .store(in: &self.subscriber)
                } else {
                    self.navigatior = .onRegistrationScreen
                }
            }
            .store(in: &subscriber)
    }
    
    func register() {
        authService.register(phone: phoneNumber, name: name, username: username)
            .sink { completion in
                let error = try? completion.error()
                print("Register Error \(error)")
            } receiveValue: { registerResponse in
                print("Register Response \(registerResponse)")
                self.remoteUserService.getCurrentUser(accessToken: registerResponse.access_token)
                    .sink { completion in
                        let error = try? completion.error()
                        print("GetCurrentUser Error \(error)")
                    } receiveValue: { userResponse in
                        print("Current user response \(userResponse)")
                        let user = self.saveUserToDB(
                            profileData: userResponse.profile_data,
                            accessToken: registerResponse.access_token,
                            refreshToken: registerResponse.refresh_token
                        )
                        self.databaseService.save(user: user)
                        self.navigatior = .toHomeScreen(user)
                    }
                    .store(in: &self.subscriber)
                
            }
            .store(in: &subscriber)
    }
    
    // Имитация отправления СМС Сообщения
    func sendVerificationCode() {
        self.notificationService.push(NotificationModel(title: "Verification Code", subtitle: "133337", timeInterval: 3))
    }
}

extension AuthenticationScreenViewModel {
    func saveUserToDB(profileData: ProfileData, accessToken: String?, refreshToken: String?) -> UserModel {
        let userObject = UserModel()
        let avatars = RealmSwift.List<String>()
        avatars.append(objectsIn: profileData.avatars ?? [])
        userObject.accessToken = accessToken
        userObject.refreshToken = refreshToken
        userObject.id = profileData.id
        userObject.name = profileData.name
        userObject.username = profileData.username
        userObject.birthday = profileData.birthday
        userObject.city = profileData.city
        userObject.avatar = profileData.avatar
        userObject.avatars = avatars
        userObject.phone = profileData.phone
        
        return userObject
    }
}

extension AuthenticationScreenViewModel {
    enum AuthNavigator {
        case onEnterPhoneNumber
        case onEnterVerificationCode
        case onRegistrationScreen
        case toHomeScreen(UserModel)
    }
}
