//
//  ScreenFactory.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation
import SwiftUI
import UserNotifications

protocol SceneFactoryProtocol {
    func makeFirstScreen() -> AnyView
}

final class SceneFactory: NSObject, SceneFactoryProtocol, UNUserNotificationCenterDelegate {
    let applicationFactory = ApplicationFactory()
    
    func makeFirstScreen() -> AnyView {
        applicationFactory.notificationService.register()
        let viewModel = VerificationScreenViewModel(authService: applicationFactory.authService, notificationService: applicationFactory.notificationService)
        return AnyView(VerificationScreen().environmentObject(viewModel))
    }
}
