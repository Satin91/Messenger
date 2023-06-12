//
//  NotificationService.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation

protocol NotificationServiceProtocol {
    func push(_ notification: NotificationModel)
}

final class NotificationService: NotificationServiceProtocol {
    private var manager: NotificationManagerProtocol
    
    init(manager: NotificationManagerProtocol) {
        self.manager = manager
    }
    
    func push(_ notification: NotificationModel) {
        manager.send(notification)
    }
}
