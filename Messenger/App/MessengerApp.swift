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
    let networkService = NetworkService()
    @State var subscriber = Set<AnyCancellable>()
    @State var isAuthorized: Bool = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isAuthorized {
                    MainScreenView()
                }
            }
            .onAppear {
                networkService.sendAuthCode(phone: "+79230464916")
                    .sink { error in
                    } receiveValue: { response in
                        if response.is_success {
                            isAuthorized = true
                        }
                    }
                    .store(in: &subscriber)
                
            }
        }
        
    }
}
