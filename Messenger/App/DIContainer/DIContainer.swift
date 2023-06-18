//
//  DIContainer.swift
//  Messenger
//
//  Created by Артур Кулик on 18.06.2023.
//

import Foundation

/// Контейнер с иньекцией основных модулей.

final class DIContainer {
    static let shared = DIContainer()
    
    private let applicationFactory = ApplicationFactory()
    
    var sceneFactory: SceneFactoryProtocol
    var userFetcher: UserFetcher
    
    init() {
        sceneFactory = SceneFactory(applicationFactory: applicationFactory)
        userFetcher = UserFetcher(applicationFactory: applicationFactory)
    }
}
