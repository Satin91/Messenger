//
//  Router.swift
//  Messenger
//
//  Created by Артур Кулик on 12.06.2023.
//

import Foundation
import SwiftUI
import FlowStacks

enum Screen {
    case verificationScreen
    case homeScreen(UserModel)
    case chatScreen(UserModel, MockChats.ChatUser)
}

struct AppCoordinator: View {
    @ObservedObject var coordinator: AppCoordinatorViewModel
    let sceneFactory = SceneFactory()
    
    init(viewModel: AppCoordinatorViewModel) {
        self.coordinator = viewModel
    }
    
    var body: some View {
        Router($coordinator.routes) { screen,_ in
            switch screen {
            case .verificationScreen:
                sceneFactory.makeAuthorizationScreen()
            case .homeScreen(let user):
                HomeScreen(user: user)
                    .toolbar(.hidden)
            case .chatScreen(let user, let companion):
                sceneFactory.makeChatScreen(user: user, companion: companion)
            }
        }
        .environmentObject(coordinator)
    }
}

class AppCoordinatorViewModel: ObservableObject {
  @Published var routes: Routes<Screen>
    
  init() {
      print("Init app coordinator")
      self.routes = [.root(.homeScreen(UserModel()), embedInNavigationView: true)]
  }
    
    func pushToHomeScreen(user: UserModel) {
        routes.push(.homeScreen(user) )
    }
    
    func pushToChatScreen(user: UserModel, companion: MockChats.ChatUser) {
        routes.push(.chatScreen(user, companion))
    }
    
    func back() {
        routes.goBack()
    }
}
