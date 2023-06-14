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
            }
        }
        .environmentObject(coordinator)
    }
}

class AppCoordinatorViewModel: ObservableObject {
  @Published var routes: Routes<Screen>
    
  init() {
      print("Init app coordinator")
      self.routes = [.root(.verificationScreen, embedInNavigationView: true)]
  }
    
    func pushToHomeScreen(user: UserModel) {
        routes.push(.homeScreen(user) )
    }
}
