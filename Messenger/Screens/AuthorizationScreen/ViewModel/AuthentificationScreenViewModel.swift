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

final class AuthentificationScreenViewModel: NSObject, ObservableObject {
    var authService: AuthentificationServiceProtocol
    var notificationService: NotificationServiceProtocol
    
    var subscriber = Set<AnyCancellable>()
    @Published var navigatior: AuthNavigator = .onEnterPhoneNumber
    @Published var pageIndex: Int = 0
    @Published var phoneNumberText = ""
    @Published var verificationCode = ""
    
    
    var isFullPhoneNumber: Bool {
        let numbers = Array(phoneNumberText).compactMap({ Int(String($0))})
        return numbers.count >= 11
    }
    
    init(authService: AuthentificationServiceProtocol, notificationService: NotificationServiceProtocol) {
        self.authService = authService
        self.notificationService = notificationService
    }

    func sendAuthCode() {
        authService.sendAuthCode(phone: phoneNumberText)
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
        authService.checkAuthCode(phone: phoneNumberText, code: verificationCode)
            .sink { completion in
                let error = try? completion.error()
                print("AuthCode Error \(error)")
            } receiveValue: { response in
                if response.is_user_exists {
                    self.navigatior = .onVerivicationSuccess
                } else {
                    self.navigatior = .goToRegistrationScreen
                }
            }
            .store(in: &subscriber)
    }
    
    // Имитация отправления СМС Сообщения
    func sendVerificationCode() {
        self.notificationService.push(NotificationModel(title: "Verification Code", subtitle: "133337", timeInterval: 3))
    }
}

extension AuthentificationScreenViewModel {
    enum AuthNavigator {
        case onEnterPhoneNumber
        case onEnterVerificationCode
        case onVerivicationSuccess
        case goToRegistrationScreen
    }
}
