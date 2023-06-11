//
//  NotificationService.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation

protocol NotificationServiceProtocol {
    func push(_ notification: NotificationModel)
    func register()
}

final class NotificationService: NotificationServiceProtocol {
    private var manager: NotificationManagerProtocol
    
    init(manager: NotificationManagerProtocol) {
        self.manager = manager
    }
    
    func register() {
        manager.register()
    }
    
    func push(_ notification: NotificationModel) {
        manager.send(notification)
    }
}
