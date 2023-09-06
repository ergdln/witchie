//
//  LevelViewExtension.swift
//  witchie
//
//  Created by egln on 31/08/23.
//

import Foundation
import SwiftUI

//MARK: Game Functions
extension LevelView{
    
    public func getDirection(from translation: CGSize) -> Direction {
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
    
    func refreshGame(){
        //print(safeDimensionManager.dimensions)
        playerMovements = 0
        levelModel[levelNumber].levelMap = LevelModel.getLevels(chapter: patch)[levelNumber].levelMap
        levelActualPosition = levelStartPosition
        levelGrid = Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: levelModel[levelNumber].levelOffset)
        levelSpotsIndex = LevelModel.getIndexes(of: spot, in: levelModel[levelNumber].levelMap)
        levelStartPosition = LevelModel.getIndexes(of: person, in: levelModel[levelNumber].levelMap)[0]
        levelActualPosition = LevelModel.getIndexes(of: person, in: levelModel[levelNumber].levelMap)[0]
    }
    
    //MARK: main movement function
    func defineMoviment(actualPosition: Int, offset: Int){
        //FACED A HOLE
        if levelModel[levelNumber].levelMap[actualPosition + offset] == hole {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                refreshGame()
            }
        }
        //WALKING IN FREE SPACE
        else if levelModel[levelNumber].levelMap[actualPosition + offset] == grass {
            levelModel[levelNumber].levelMap.swapAt(actualPosition + offset, actualPosition)
            levelActualPosition = actualPosition + offset
            //recursion stop condition
            if (levelModel[levelNumber].levelMap[levelActualPosition + offset] == box) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == wall) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == spot) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == crate) {
                //here, nothing happens
                //you hit something, so it's just time to stop walking
                //then finally it's it time to count the movement:
                playerMovements += 1
                
            }//recursion is called when the next block is TILE_FLOOR
            else{
                defineMoviment(actualPosition: levelActualPosition, offset: offset)
                //keep walking
            }
        }
        //PUSHING CRATE
               else if levelModel[levelNumber].levelMap[levelActualPosition + offset] == crate && levelModel[levelNumber].levelMap[actualPosition + offset + offset] == grass{
                   
                   levelModel[levelNumber].levelMap[actualPosition] = grass
                   levelModel[levelNumber].levelMap[actualPosition + offset] = person
                   levelModel[levelNumber].levelMap[actualPosition + offset + offset] = crate
                   levelActualPosition = actualPosition + offset
                   //if you successfully pushed a box, update playerMovements
                   playerMovements += 1
               }
        //PUSHING A CAULDRON
        //pushing a cauldron to a magic mark
        else if levelModel[levelNumber].levelMap[levelActualPosition + offset] == box && !levelSpotsIndex.contains(levelActualPosition + offset) {
            //sound effectsssssss here??????
            if levelModel[levelNumber].levelMap[actualPosition + offset + offset] == spot {
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
                //if you successfully pushed a box, update playerMovements
                playerMovements += 1
            }
            //pushing a cauldron in free space
            else if levelModel[levelNumber].levelMap[actualPosition + offset + offset] == grass {
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
                //if you successfully pushed a box, update playerMovements
                playerMovements += 1
            }
        }
        if isLevelCompleted(platesPosition: levelSpotsIndex){
            self.isGameOver.toggle()
            if patch == 1{
                LevelCompleted.isCompleted[1]![levelNumber] = true
                UserDefaults.standard.set(LevelCompleted.isCompleted[1], forKey: "CurrentLevel")
            }
            UserDefaults.standard.set(true, forKey: "isNotFirstTime")
            if playerMovements < UserSettings.records[patch]![levelNumber] || UserSettings.records[patch]![levelNumber] == 0 {
                UserSettings.records[patch]![levelNumber] = playerMovements
                UserDefaults.standard.set(UserSettings.records[patch], forKey: "records\(patch)")
            }
        }
    }
    
    //    func playCauldronSoundEffects(){
    //        var audioPlayer: AVAudioPlayer
    //        let url = Bundle.main.url(forResource: "CauldronAlert", withExtension: "mp3")
    //        guard url != nil else {
    //            return
    //        }
    //        do {
    //            audioPlayer = try AVAudioPlayer(contentsOf: url!)
    //            audioPlayer?.play()
    //        } catch {
    //
    //        }
    //    }
    
    //MARK: function that checks if the level is completed
    func isLevelCompleted(platesPosition: [Int]) -> Bool{
        if (platesPosition.allSatisfy{levelModel[levelNumber].levelMap[$0] == box}){
            
            return true
        }
        else{
            return false
        }
    }
}

