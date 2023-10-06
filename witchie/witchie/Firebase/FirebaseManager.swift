//
//  FirebaseManager.swift
//  Witchie
//
//  Created by jpbol on 06/10/2023.
//

import Foundation
import FirebaseAnalytics

class FirebaseManager {
    
    func level_started (patch: Int, level: Int) {
        Analytics.logEvent(AnalyticsEventLevelStart, parameters: [AnalyticsParameterLevelName: "\(patch): \(level + 1)"])
    }
    
    func level_completed (patch: Int, level: Int, playerMovements: Int, timePlayed: Int, refreshes: Int ) {
        Analytics.logEvent("level_completed", parameters: [AnalyticsParameterLevelName: "\(patch): \(level + 1) completed", "player_movements": playerMovements, "time_played": timePlayed, "refreshes": refreshes])
    }
}
