//
//  NotificationService.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation

protocol NotificationServiceProtocol {
    func push(_ notification: NotificationModel) async throws -> Bool
}

final class NotificationService: NotificationServiceProtocol {
    private var manager: NotificationManagerProtocol
    
    init(manager: NotificationManagerProtocol) {
        self.manager = manager
    }
    
    func push(_ notification: NotificationModel) async throws -> Bool {
        try await withCheckedThrowingContinuation({ continuation in
            manager.send(notification) { error in
                if error != nil {
                    continuation.resume(throwing: error!)
                } else {
                    continuation.resume(with: .success(true))
                }
            }
        })
    }
}
