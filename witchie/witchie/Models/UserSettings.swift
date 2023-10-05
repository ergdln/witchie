//
//  LevelCompleted.swift
//  witchie
//
//  Created by ditthales on 26/07/23.
//

import Foundation
import SwiftUI

//Legado, não mexe e não apaga
struct LevelCompleted{
    static var isCompleted: [Int:[Bool]] = [
            1: Array(repeating: false, count: LevelModel.patchOne().count),
        ]
}

struct LevelInformation {
    var patch: Int
    var level: Int
    var showOnboarding: Bool?
}

struct UserSettings{
    
    static var isNotFirstTime: [Bool] = [UserDefaults.standard.bool(forKey: "isNotFirstTime")] + Array.init(repeating: false, count: UserSettings.records.count - 1)
    
    static var records: [Int: [Int]] = [
        1: Array(repeating: 0, count: LevelModel.patchOne().count),
        2: Array(repeating: 0, count: LevelModel.patchTwo().count),
        3: Array(repeating: 0, count: LevelModel.patchThree().count),
    ]
    
    static var hasSeenNewChapter: Bool = false
    
    static var currentLevel: LevelInformation = LevelInformation(patch: 1, level: 0)
}
