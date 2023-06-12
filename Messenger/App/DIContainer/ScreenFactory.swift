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

final class SceneFactory: NSObject, SceneFactoryProtocol {
    let applicationFactory = ApplicationFactory()
    
    func makeFirstScreen() -> AnyView {
        return AnyView(VerificationScreen().environmentObject(applicationFactory.verificationScreenViewModel))
    }
}
