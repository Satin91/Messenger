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

final class VerificationScreenViewModel: NSObject, ObservableObject {
    var authService: AuthentificationServiceProtocol
    var notificationService: NotificationServiceProtocol
    var subscriber = Set<AnyCancellable>()
    
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
                guard self.pageIndex != 1 else { return }
                self.pageIndex = 1
            }
            .store(in: &subscriber)
    }
    
    func checkAuthCode() {
        authService.checkAuthCode(phone: phoneNumberText, code: verificationCode)
            .sink { completion in
                let error = try? completion.error()
                print("Error \(error)")
            } receiveValue: { response in
                guard self.pageIndex != 1 else { return }
                self.pageIndex = 1
            }
            .store(in: &subscriber)
    }
    
    func goNext() {
        pageIndex = 1
    }
    
    func goBack() {
        pageIndex = 0
    }
    
    // Имитация отправления СМС Сообщения
    func sendVerificationCode() {
        self.notificationService.push(NotificationModel(title: "Verification Code", subtitle: "133337", timeInterval: 3))
    }
}
