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
    
    let sceneFactory = SceneFactory()
    
    var body: some Scene {
        WindowGroup {
            sceneFactory.makeFirstScreen()
        }
    }
}
