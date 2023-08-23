//
//  UserSettings.swift
//  witchie
//
//  Created by jpbol on 23/08/2023.
//

import Foundation

struct UserSettings{
    static var hasReviewed: Bool = false
    static var isNotFirstTime: Bool = false
    static var records: [Int: [Int]] = [
        1: Array(repeating: 0, count: LevelModel.patchOne().count)
    ]
}
