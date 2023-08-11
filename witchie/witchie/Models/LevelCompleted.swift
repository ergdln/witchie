//
//  LevelCompleted.swift
//  witchie
//
//  Created by ditthales on 26/07/23.
//

import Foundation
import SwiftUI

struct LevelCompleted{
    static var isCompleted: [Bool] = Array(repeating: false, count: LevelModel.patchOne().count)
}

struct UserSettings{
    static var isNotFirstTime: Bool = false
}
