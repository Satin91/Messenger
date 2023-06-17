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
            } receiveValue: { response in
                self.sendVerificationCode()
                self.navigatior = .onEnterVerificationCode
            }
            .store(in: &subscriber)
    }
    
    func checkAuthCode() {
        authService.checkAuthCode(phone: phoneNumber, code: verificationCode)
            .flatMap { response  in
                if response.is_user_exists {
                    SessionInfo.shared.refreshToken = response.refresh_token
                    SessionInfo.shared.accessToken = response.access_token
                    SessionInfo.shared.userID = response.user_id
                    return self.remoteUserService.getCurrentUser(accessToken: response.access_token!)
                }
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .sink { error in
                self.navigatior = .onError("Неверный код авторизации :(")
            } receiveValue: { userResponse in
                userResponse.profile_data.id = SessionInfo.shared.userID!
                userResponse.profile_data.accessToken = SessionInfo.shared.accessToken
                userResponse.profile_data.refreshToken = SessionInfo.shared.refreshToken
                self.navigatior = .toChatList(userResponse.profile_data)
                self.databaseService.save(user: userResponse.profile_data)
            }
            .store(in: &subscriber)

    }
    
    func register() {
        authService.register(phone: phoneNumber, name: name, username: username)
            .sink { completion in
            } receiveValue: { registerResponse in
                self.remoteUserService.getCurrentUser(accessToken: registerResponse.access_token)
                    .sink { completion in
                    } receiveValue: { userResponse in
                        let user = userResponse.profile_data
                        user.id = registerResponse.user_id
                        user.refreshToken = registerResponse.refresh_token
                        user.accessToken = registerResponse.access_token
                        self.navigatior = .toChatList(user)
                    }
                    .store(in: &self.subscriber)
                
            }
            .store(in: &subscriber)
    }
    
    // Имитация отправления СМС Сообщения
    func sendVerificationCode() {
        self.notificationService.push(NotificationModel(title: "Verification Code", subtitle: "133337", timeInterval: 2))
    }
}

extension AuthenticationScreenViewModel {
    enum AuthNavigator {
        case onEnterPhoneNumber
        case onEnterVerificationCode
        case onRegistrationScreen
        case onError(String)
        case toChatList(UserModel)
    }
}

//extension Subscribers.Completion {
//    var error2: Failure? {
//        switch self {
//        case let .failure(error): return error
//        default: return nil
//        }
//    }
//}
