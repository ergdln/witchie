//
//  NotificationManager.swift
//  Witchie
//
//  Created by Guilherme Souza on 26/09/23.
//

import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    
    static let shared = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestNotificationAuthorization (){
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    
    func scheduleNotifications () {
        scheduleNotification(typeOfNotification: .twoDays)
        scheduleNotification(typeOfNotification: .oneWeek)
        scheduleNotification(typeOfNotification: .twoWeeks)
    }
    
    private func scheduleNotification (typeOfNotification: notificationType){
        let content = UNMutableNotificationContent()
        content.title = typeOfNotification.title
        content.body = typeOfNotification.body
        content.sound = typeOfNotification.sound
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: typeOfNotification.timeInterval, repeats: typeOfNotification.repeats)
        
        let request = UNNotificationRequest(identifier: typeOfNotification.identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func clearNotifications (notificationIdentifier: String){
        if notificationIdentifier == "Inactivity" {
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["twoDaysInactivityNotification", "oneWeekInactivityNotification", "twoWeekInactivityNotification"])
            print("Notifications cleared")
        }
        
    }
}
