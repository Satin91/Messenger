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
    func makeAuthorizationScreen() -> AnyView
    func makeRegistrationScreen(phoneNumber: String) -> AnyView
}

final class SceneFactory: NSObject, SceneFactoryProtocol {
    
    let applicationFactory = ApplicationFactory()
    
    func makeRegistrationScreen(phoneNumber: String) -> AnyView {
        AnyView(RegistrationScreen(viewModel: self.applicationFactory.registrationScreenViewModel(phoneNumber: phoneNumber)))
    }
    
    // Инициализация экрана Аутентификации производится с environmentObject'ом, по причине наличия в этом экране нескольких subView.
    func makeAuthorizationScreen() -> AnyView {
        AnyView(AunthentificationScreen().environmentObject(applicationFactory.verificationScreenViewModel))
    }
}
