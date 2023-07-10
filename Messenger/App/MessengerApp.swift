//
//  MessengerApp.swift
//  Messenger
//
//  Created by Артур Кулик on 08.06.2023.
//

import SwiftUI
import Combine
import Alamofire

@main
struct MessengerApp: App {
    let contailer = DIContainer()
    
    @State var cancelBag = Set<AnyCancellable>()
    var body: some Scene {
        WindowGroup {
            AppCoordinator(userFetcher: contailer.userFetcher, sceneFactory: contailer.sceneFactory)
        }
    }
}
