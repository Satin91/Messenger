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

/*
 Обязанности модели:
 - Ввод номера телефона
 - Отправка кода авторизации
 - Проверка на присутствие пользователя в базе
 - Вывод ошибок связанных с неправильными данными
 - Авторизация
 - Регистрация
 */

final class AuthenticationScreenViewModel: NSObject, ObservableObject {
    var authService: AuthServiceProtocol
    var notificationService: NotificationServiceProtocol
    var remoteUserService: RemoteUserServiceProtocol
    var userDatabaseService: UserDatabaseServiceProtocol
    var subscriber = Set<AnyCancellable>()
    
    @Published var navigatior: AuthNavigator = .onEnterPhoneNumber
    @Published var phoneNumber: String = ""
    @Published var verificationCode = ""
    @Published var name = ""
    @Published var username = ""
    @Published var registerSuccess: Bool = false
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    
    @State var isValidPhoneNumber: Bool = false
    
    init(authService: AuthServiceProtocol, databaseService: UserDatabaseServiceProtocol,  notificationService: NotificationServiceProtocol, remoteUserService: RemoteUserServiceProtocol) {
        self.authService = authService
        self.notificationService = notificationService
        self.remoteUserService = remoteUserService
        self.userDatabaseService = databaseService
    }
    
    // MARK: Отправление кода авторизации по набранному номеру
    
    func sendAuthCode() {
        authService.sendAuthCode(phone: phoneNumber)
            .sink { completion in
                if let error = completion.error {
                    self.showAlert(message: error.localizedDescription ?? "Произошла какая то ошибка")
                }
            } receiveValue: { response in
                self.sendVerificationCode()
                self.navigatior = .onEnterVerificationCode
            }
            .store(in: &subscriber)
    }
    
    // MARK: Проверка введенного кода авторизации и присутствия пользователя в базе
    
    func checkAuthCode() {
        authService.checkAuthCode(phone: phoneNumber, code: verificationCode)
            .flatMap { typeResponse in
                switch typeResponse {
                case .response(let response):
                    if response.is_user_exists {
                        /// Пользователь существует, получить его данные из сервера.
                        SessionInfo.shared.refreshToken = response.refresh_token
                        SessionInfo.shared.accessToken = response.access_token
                        SessionInfo.shared.userID = response.user_id
                        return self.remoteUserService.getCurrentUser(accessToken: response.access_token!)
                    } else {
                        /// Пользователь отсутствует, направить на регистрацию.
                        self.navigatior = .onRegistrationScreen
                        return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                    }
                    /// Код авторизации неверный, вывести ошибку.
                case .error(let error):
                    self.showAlert(message: error.detail.message)
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
            }
            .receive(on: RunLoop.main)
            .sink { error in
            } receiveValue: { userResponse in
                /// Код авторизации верный, авторизовать пользователя, сохранить его данные, сделать его текущим.
                let user = userResponse.profile_data
                user.id = SessionInfo.shared.userID!
                user.accessToken = SessionInfo.shared.accessToken
                user.refreshToken = SessionInfo.shared.refreshToken
                self.navigatior = .toChatList(userResponse.profile_data)
                self.userDatabaseService.setCurrentUser(user: user)
                self.userDatabaseService.save(user: user)
            }
            .store(in: &subscriber)
    }
    
    // MARK: Регистрация
    
    func register() {
        authService.register(phone: phoneNumber, name: name, username: username)
        /// Получение отклика после нажатия кнопки "регистрация"
            .flatMap { registerResponse in
                SessionInfo.shared.userID = registerResponse.user_id
                SessionInfo.shared.accessToken = registerResponse.access_token
                SessionInfo.shared.refreshToken = registerResponse.refresh_token
                return self.remoteUserService.getCurrentUser(accessToken: registerResponse.access_token)
            }
            .sink { _ in
            } receiveValue: { userResponse in
                /// Создание объекта User
                let user = userResponse.profile_data
                user.id = SessionInfo.shared.userID!
                user.refreshToken = SessionInfo.shared.refreshToken
                user.accessToken = SessionInfo.shared.accessToken
                self.userDatabaseService.setCurrentUser(user: user)
                self.navigatior = .toChatList(user)
            }
            .store(in: &self.subscriber)
    }
    
    // MARK: Имитация отправки СМС с кодом авторизации
    
    func sendVerificationCode() {
        self.notificationService.push(NotificationModel(title: "Код ", subtitle: "133337", timeInterval: 2))
    }
    
    // MARK: Демонстрация ошибки
    func showAlert(message: String) {
        self.alertMessage = message
        showAlert.toggle()
    }
}

//MARK: Внутренний навигатор

extension AuthenticationScreenViewModel {
    enum AuthNavigator: Equatable {
        case onEnterPhoneNumber
        case onEnterVerificationCode
        case onRegistrationScreen
        case toChatList(UserModel)
    }
}
