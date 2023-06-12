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
    
    init(authService: AuthentificationServiceProtocol, notificationService: NotificationServiceProtocol) {
        self.authService = authService
        self.notificationService = notificationService
        super.init()
        notificationService.register()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func checkAuthCode(phone: String) {
        authService.sendAuthCode(phone: phone)
            .sink(receiveCompletion: { completion in
                let error = try? completion.error()
                print("Error \(error)")
            }, receiveValue: { response in
                self.sendVerificationCode()
                guard self.pageIndex != 1 else { return }
                self.goNext()
            })
            .store(in: &subscriber)
    }
    
    func goNext() {
        pageIndex = 1
    }
    
    func goBack() {
        pageIndex = 0
    }
    
    func sendVerificationCode() {
        self.notificationService.push(NotificationModel(title: "Verification Code", subtitle: "133337", timeInterval: 3))
    }
}

// Реализация делегата для получения уведомления при открытом приложении.
extension VerificationScreenViewModel: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
}
