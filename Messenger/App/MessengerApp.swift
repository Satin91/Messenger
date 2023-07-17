//
//  MessengerApp.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import SwiftUI

@main
struct MessengerApp: App {
    let contailer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            AppCoordinator(userFetcher: contailer.userFetcher, sceneFactory: contailer.sceneFactory)
        }
    }
}
