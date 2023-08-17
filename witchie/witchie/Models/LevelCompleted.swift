//
//  LevelCompleted.swift
//  witchie
//
//  Created by ditthales on 26/07/23.
//

import Foundation
import SwiftUI

struct LevelCompleted{
    static var isCompleted: [Int:[Bool]] = [
            1: Array(repeating: false, count: LevelModel.patchOne().count)
        ]
}

struct UserSettings{
    static var isNotFirstTime: Bool = false
    static var records: [Int: [Int]] = [
        1: Array(repeating: 0, count: LevelModel.patchOne().count)
    ]
}
