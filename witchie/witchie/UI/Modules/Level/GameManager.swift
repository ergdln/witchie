//
//  GameManager.swift
//  Witchie
//
//  Created by ditthales on 03/10/23.
//

import SwiftUI

class GameManager: ObservableObject {
    
    @Published var gestureOffset: CGSize = .zero
    @Published var direction: GestureDirection = .none
    
    @Published var levelArray: [String]

    func defineMovement(map: inout [String]) {
        
        if 
        
    }
    
    func getDirection(from translation: CGSize) -> GestureDirection {
        let x = translation.width
        let y = translation.height
        
        if x > 25 && abs(y) < x {
            return .right
        } else if x < -25 && abs(y) < abs(x) {
            return .left
        } else if y > 25 && abs(x) < y {
            return .down
        } else if y < -25 && abs(x) < abs(y) {
            return .up
        }
        
        return .none
    }
}
