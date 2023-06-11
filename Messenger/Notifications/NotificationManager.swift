//
//  NotificationManager.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    func send(_ notification: NotificationModel, completion: @escaping (Error?) -> Void)
}

final class NotificationManager: NotificationManagerProtocol {
    let center = UNUserNotificationCenter.current()
    
    func registerForPushNotifications() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (permissionGranted, error) in
            DispatchQueue.main.async {
                guard permissionGranted else {
                    return
                }
            }
        }
    }
    
    func send(_ notification: NotificationModel, completion: @escaping (Error?) -> Void) {
        let request = makeRequest(model: notification)
        center.add(request) { error in
            completion(error)
        }
    }
    
    private func makeRequest(model: NotificationModel) -> UNNotificationRequest {
        let content = makeContent(title: model.title, body: model.subtitle)
        let trigger = self.makeTrigger(timeInterval: model.timeInterval)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        return request
    }
    
    private func makeTrigger(timeInterval: TimeInterval) -> UNTimeIntervalNotificationTrigger {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        return trigger
    }
    
    private func makeContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        return content
    }
}
