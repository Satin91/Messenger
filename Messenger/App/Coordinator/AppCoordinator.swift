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
    case chatScreen(UserModel, MockChats.ChatUser)
    case profileScreen(UserModel)
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
    
  init() {
      let manager = DatabaseManager()
      let result = manager.fetch(type: UserModel.self)
      if result .isEmpty {
          self.routes = [.root(.verificationScreen, embedInNavigationView: true)]
      } else {
          self.routes = [.root(.chatListScreen(result.first!), embedInNavigationView: true)]
      }
  }
    
    func pushToChatList(user: UserModel) {
        routes.push(.chatListScreen(user) )
    }
    
    func pushToChatScreen(user: UserModel, companion: MockChats.ChatUser) {
        routes.push(.chatScreen(user, companion))
    }
    
    func pushToProfileScreen(user: UserModel) {
        routes.push(.profileScreen(user))
    }
    
    func back() {
        routes.goBack()
    }
}