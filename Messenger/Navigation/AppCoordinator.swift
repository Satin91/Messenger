//
//  AppCoordinator.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import Foundation
import SwiftUI
import FlowStacks

enum Screen {
    case verificationScreen
    case chatListScreen(UserModel)
    case chatScreen(UserModel, CompanionModel)
    case profileScreen(UserModel)
}

struct AppCoordinator: View {
    @ObservedObject var coordinator: AppCoordinatorViewModel
    let sceneFactory: SceneFactoryProtocol
    let userFetcher: UserFetcher
    
    init(userFetcher: UserFetcher, sceneFactory: SceneFactoryProtocol) {
        self.userFetcher = userFetcher
        self.coordinator = AppCoordinatorViewModel(currentUser: userFetcher.fetchCurrentUser())
        self.sceneFactory = sceneFactory
    }
    
    var body: some View {
        Router($coordinator.routes) { screen,_ in
            switch screen {
            case .verificationScreen:
                sceneFactory.makeAuthenticationScreen()
                    .toolbar(.hidden)
            case .chatListScreen(let user):
                sceneFactory.makeChatListScreen(user: user)
                    .toolbar(.hidden)
            case .chatScreen(let user, let companion):
                sceneFactory.makeChatScreen(user: user, companion: companion)
                    .toolbar(.hidden)
            case .profileScreen(let user):
                sceneFactory.makeProfileScreen(user: user)
                    .toolbar(.hidden)
            }
        }
        .environmentObject(coordinator)
    }
}

class AppCoordinatorViewModel: ObservableObject {
    @Published var routes: Routes<Screen>
    var currentUser: UserModel?
    
    init(currentUser: UserModel?) {
        if let currentUser = currentUser {
            self.routes = [.root(.chatListScreen(currentUser), embedInNavigationView: true)]
        } else {
            self.routes = [.root(.verificationScreen, embedInNavigationView: true)]
        }
    }
    
    func backToRootView() {
        routes = [.root(.verificationScreen, embedInNavigationView: true)]
    }
    
    func pushToChatListScreen(user: UserModel) {
        routes.push(.chatListScreen(user) )
    }
    
    func pushToChatScreen(user: UserModel, companion: CompanionModel) {
        routes.push(.chatScreen(user, companion))
    }
    
    func pushToProfileScreen(user: UserModel) {
        routes.push(.profileScreen(user))
    }
    
    func back() {
        routes.goBack()
    }
}
