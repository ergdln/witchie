//
//  NotificationType.swift
//  Witchie
//
//  Created by Guilherme Souza on 26/09/23.
//

import Foundation
import UserNotifications

enum notificationType {
    
    case twoDays
    case oneWeek
    case twoWeeks
    
    var identifier: String {
        
        switch self {
        case .twoDays:
            return "twoDaysInactivityNotification"
        case .oneWeek:
            return "oneWeekInactivityNotification"
        case .twoWeeks:
            return "twoWeeksInactivityNotification"
        }
    }
    
    var title: String {
           switch self {
           case .twoDays:
               return ContentComponent.TITLE1
           case .oneWeek:
               return ContentComponent.TITLE2
           case .twoWeeks:
               return ContentComponent.TITLE3
           }
           
       }
       
       var body: String {
           switch self {
           case .twoDays:
               return ContentComponent.BODY1
           case .oneWeek:
               return ContentComponent.BODY2
           case .twoWeeks:
               return ContentComponent.BODY3
           }
       }
       
       var timeInterval: TimeInterval {
           switch self {
           case .twoDays:
               return 172800
           case .oneWeek:
               return 604800
           case .twoWeeks:
               return 1209600
           }
       }
       
       var repeats: Bool {
           switch self {
           case .twoDays:
               return false
           case .oneWeek:
               return false
           case .twoWeeks:
               return true
           }
       }
    
    var sound: UNNotificationSound {
            switch self {
            case .twoDays:
                return .default
            case .oneWeek:
                return .default
            case .twoWeeks:
                return .default
            }
        }
}
