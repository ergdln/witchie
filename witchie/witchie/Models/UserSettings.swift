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

struct UserSettings{
    static var isNotFirstTime: Bool = false
    static var records: [Int: [Int]] = [
        1: Array(repeating: 0, count: LevelModel.patchOne().count),
        2: Array(repeating: 0, count: LevelModel.patchTwo().count),
    ]
}
