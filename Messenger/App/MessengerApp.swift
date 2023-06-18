//
//  MessengerApp.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import SwiftUI
import Combine

@main
struct MessengerApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator(
                viewModel: AppCoordinatorViewModel(currentUser: DIContainer.shared.userFetcher.fetchCurrentUser())
            )
        }
    }
}
