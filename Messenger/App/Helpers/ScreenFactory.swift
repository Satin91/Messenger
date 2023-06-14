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
}

final class SceneFactory: NSObject, SceneFactoryProtocol {
    
    let applicationFactory = ApplicationFactory()
    
    // Инициализация экрана Аутентификации производится с environmentObject'ом, по причине наличия в этом экране нескольких subView.
    func makeAuthorizationScreen() -> AnyView {
        AnyView(AuthenticationScreen().environmentObject(applicationFactory.verificationScreenViewModel))
    }
}
