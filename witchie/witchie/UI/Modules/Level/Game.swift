//
//  Level2.swift
//  Witchie
//
//  Created by ditthales on 29/09/23.
//  
//

import SwiftUI

enum Movement {
    case witchToHole, witchWalking, boxToMark, boxToGrass, crateToHole, crateToGrass, invalid
}

struct Game {
    
    let box = ContentComponent.BOX
    let grass = ContentComponent.GRASS
    let person = ContentComponent.PERSON
    let wall = ContentComponent.WALL
    let spot = ContentComponent.SPOT
    let empty = ContentComponent.EMPTY
    let hole = ContentComponent.HOLE
    let crate = ContentComponent.CRATE
    
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
    
    func defineMovement(levelArray: [String], actualPosition: Int, offset: Int, spotsIndex: [Int] ,handler: @escaping (_ movement: Movement) -> Void) {
        if levelArray[actualPosition + offset] == hole{
            handler(.witchToHole)
        } else if levelArray[actualPosition + offset] == grass {
            handler(.witchWalking)
        } else if levelArray[actualPosition + offset] == crate && levelArray[actualPosition + offset + offset] == grass {
            handler(.crateToGrass)
        } else if levelArray[actualPosition + offset] == box && !spotsIndex.contains(actualPosition + offset) && levelArray[actualPosition + offset + offset] == spot {
            handler(.boxToMark)
        } else if levelArray[actualPosition + offset] == box && !spotsIndex.contains(actualPosition + offset) && levelArray[actualPosition + offset + offset] == grass {
            handler(.boxToGrass)
        } else if levelArray[actualPosition + offset] == crate && levelArray[actualPosition + offset + offset] == hole {
            handler(.crateToHole)
        } else {
            handler(.invalid)
        }
    }
    
}
