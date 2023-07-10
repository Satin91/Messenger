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
    let balabobaService = BalabobaService(networkManager: NetworkManager(session: Session()))
    @State var cancelBag = Set<AnyCancellable>()
    var body: some Scene {
        WindowGroup {
            AppCoordinator(userFetcher: contailer.userFetcher, sceneFactory: contailer.sceneFactory)
                .onAppear {
                    balabobaService.sendMessage(query: "Как поживаешь ?")
                        .sink { error in
                            print("DEBUG: Error message \(error)")
                        } receiveValue: { resultData in
                            print("DEBUG: ResultData \(resultData.text)")
                        }
                        .store(in: &self.cancelBag)
                }
        }
    }
}
