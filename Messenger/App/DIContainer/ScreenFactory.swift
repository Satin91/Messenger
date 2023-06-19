//
//  ScreenFactory.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import SwiftUI


// Модуль, который создаёт представления и их зависимости.

protocol SceneFactoryProtocol {
    func makeAuthenticationScreen() -> AnyView
    func makeChatListScreen(user: UserModel) -> AnyView
    func makeChatScreen(user: UserModel, companion: MockChats.ChatUser) -> AnyView
    func makeProfileScreen(user: UserModel) -> AnyView
}

final class SceneFactory: SceneFactoryProtocol {
    
    let applicationFactory: ApplicationFactory
    
    init(applicationFactory: ApplicationFactory) {
        self.applicationFactory = applicationFactory
    }
    
    /* Инициализация экрана Аутентификации производится с environmentObject'ом, по причине наличия в этом экране нескольких subViewю
     Взаимодействие происходит при обращении к модели напрямую.
     */
    func makeAuthenticationScreen() -> AnyView {
        AnyView(AuthenticationScreen().environmentObject(applicationFactory.verificationScreenViewModel))
    }
    
    func makeChatListScreen(user: UserModel) -> AnyView {
        AnyView(ChatListScreen(viewModel: self.applicationFactory.chatListScreenViewModel(user: user)))
    }
    
    func makeChatScreen(user: UserModel, companion: MockChats.ChatUser) -> AnyView {
        AnyView(ChatScreen(viewModel: self.applicationFactory.chatScreenViewModel(user: user, companion: companion)))
    }
    
    func makeProfileScreen(user: UserModel) -> AnyView {
        AnyView(ProfileScreen(viewModel: self.applicationFactory.profileScreenViewModel(user: user)))
    }
}
