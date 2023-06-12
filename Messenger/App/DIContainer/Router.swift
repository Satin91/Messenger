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
    case homeScreen
}

struct AppCoordinator: View {
    @ObservedObject var viewModel: AppCoordinatorViewModel
    let sceneFactory = SceneFactory()
    
    init(viewModel: AppCoordinatorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Router($viewModel.routes) { screen,_ in
            switch screen {
            case .verificationScreen:
                sceneFactory.makeFirstScreen().environmentObject(viewModel)
            case .homeScreen:
                HomeScreen()
            }
        }
    }
}

class AppCoordinatorViewModel: ObservableObject {
  @Published var routes: Routes<Screen>
    
  init() {
      self.routes = [.root(.verificationScreen, embedInNavigationView: true)]
  }
    
    func pushToHomeScreen() {
        routes.push(.homeScreen)
    }
}
