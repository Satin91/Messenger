//
//  NotificationManager.swift
//  Messenger
//
//  Created by Артур Кулик on 11.06.2023.
//

import Foundation
import UserNotifications

protocol NotificationManagerProtocol {
    func send(_ notification: NotificationModel)
}

final class NotificationManager: NSObject, NotificationManagerProtocol {
    let center = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        self.register()
        UNUserNotificationCenter.current().delegate = self
    }
    
    private func register() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (permissionGranted, error) in
            DispatchQueue.main.async {
                guard permissionGranted else {
                    // TODO: save this to core data and show alert when notification called
                    return
                }
            }
        }
    }
    
    func send(_ notification: NotificationModel) {
        let request = makeRequest(model: notification)
        center.add(request)
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
        content.sound = .default
        return content
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
}

