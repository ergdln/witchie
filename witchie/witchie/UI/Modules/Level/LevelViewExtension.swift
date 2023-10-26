//
//  LevelViewExtension.swift
//  witchie
//
//  Created by egln on 31/08/23.
//

import Foundation
import SwiftUI
//import FirebaseAnalytics

//MARK: Game Functions
extension LevelView{
    
    // O que tá aqui vai pra LevelViewModel
    // LevelViewExtension na vdd é uma LevelViewModel da shopee
    
    // GameManager
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
    
    // GameManager
    func refreshGame(){
        //print(safeDimensionManager.dimensions)
        playerMovements = 0
        levelModel[levelNumber].levelMap = LevelModel.getLevels(chapter: patch)[levelNumber].levelMap
        levelActualPosition = levelStartPosition
        levelGrid = Array(repeating: GridItem(.flexible(minimum: 15, maximum: 150), spacing: 0), count: levelModel[levelNumber].levelOffset)
        levelSpotsIndex = LevelModel.getIndexes(of: spot, in: levelModel[levelNumber].levelMap)
        levelStartPosition = LevelModel.getIndexes(of: person, in: levelModel[levelNumber].levelMap)[0]
        levelActualPosition = LevelModel.getIndexes(of: person, in: levelModel[levelNumber].levelMap)[0]
    }
    
    // AnalyticsManager
    fileprivate func levelEndAnalytics() {
        //Analytics.logEvent("level_completed", parameters: [AnalyticsParameterLevelName: "\(patch): \(levelNumber + 1) completed", "player_movements": playerMovements, "time_played": timePlayed, "refreshes": refreshes])
    }
    
    // ReviewManager
    fileprivate func showReviewPrompt() {
        //Asking for Evaluation when it's the first time passing Level 6
        if (UserSettings.records[1]![5] == 0 || UserSettings.records[2]![5] == 0) && levelNumber == 5 {
            requestReview()
        }
    }
    
    
    //MARK: main movement function
    // GameManager
    func defineMovement(actualPosition: Int, offset: Int){
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
                defineMovement(actualPosition: levelActualPosition, offset: offset)
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
                if !isLevelCompleted(platesPosition: levelSpotsIndex){
                    fxPlayerManager.playBoxInMarkFX(patch: patch)
                }
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
        }else{
            print("movimento invalido")
        }
        
        
        
        if isLevelCompleted(platesPosition: levelSpotsIndex){
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                showEnding.toggle()
                fxPlayerManager.stopSound()
                audioPlayerManager.audioPlayer?.volume = 0.07
            }
            self.isGameOver.toggle()
            showReviewPrompt()
            levelEndAnalytics()
            refreshes = 0
            timePlayed = 0
            fxPlayerManager.playLevelCompletedFX(patch: patch)
            audioPlayerManager.audioPlayer?.volume = 0
            if patch == 1{
                defaultsManager.setLevelCompleted(level: levelNumber)
            }
            defaultsManager.setUserFirstTime(value: true, patch: patch)
            if playerMovements < UserSettings.records[patch]![levelNumber] || UserSettings.records[patch]![levelNumber] == 0 {
                defaultsManager.setNewRecord(patch: patch, level: levelNumber, value: playerMovements)
            }
        }
    }
    
    //MARK: function that checks if the level is completed
    // GameManager
    func isLevelCompleted(platesPosition: [Int]) -> Bool{
        if (platesPosition.allSatisfy{levelModel[levelNumber].levelMap[$0] == box}){
            return true
        } else {
            return false
        }
    }
    
    // Essas três funções aqui vão para o PatchModel
    func getPatchAssets(patch: Int, images: [String]) -> String {
        guard patch >= 1 && patch <= images.count else {
            return "default_image" //caso seja um valor de patch inválido
        }
        return images[patch - 1] //subtrai 1 do patch para corresponder ao índice do array
    }
    
    func getPatchBackground(patch: Int, backgrounds: [AnyView]) -> AnyView {
        guard patch >= 1 && patch <= backgrounds.count else {
            return AnyView(Text("default_background"))
        }
        return backgrounds[patch - 1]
    }
    
    func getAnimation(patch: Int) -> AnimatingImage{
        if patch == 1 {
            return AnimatingImage(images: patch1animation, interval: 0.05)
        }else if patch == 2{
            return AnimatingImage(images: patch2animation, interval: 0.07, shouldLock: true)
        }
        return AnimatingImage(images: patch2animation, interval: 0.07, shouldLock: true)
    }
}

