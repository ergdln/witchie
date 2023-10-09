//
//  Level2ViewModel.swift
//  Witchie
//
//  Created by ditthales on 29/09/23.
//  
//

import SwiftUI

// MARK: Variables to watch mark as Published. ViewModel also calls API/Core Data

final class LevelViewModel: ObservableObject {
    
    //MARK: Variables
    
    //Handles the gesture
    @Published var gestureOffset: CGSize = .zero
    @Published var direction: GestureDirection = .none
    
    //User Preferences and records
    @ObservedObject var defaultsManager = DefaultsManager.shared
    @ObservedObject var audioPlayerManager = AudioPlayerManager.shared
    @ObservedObject var fxPlayerManager = FXPlayerManager()
        
    //Control Varibles
    @Published var showEnding: Bool = false
    @Published var showOnboarding: Bool = UserSettings.currentLevel.showOnboarding ?? false
    @Published var showOnboarding2: Bool = false
    @Published var isGameOver = false
    @Published var playerMovements: Int = 0
    @Published var refreshes: Int = 0
    @Published var timePlayed: Int = 0
    
    //Information required from the LevelView to construct the ViewModel
    @Published var patch: Int
    @Published var levelNumber: Int
    
    //The Map Array itself
    @Published var levelArray: [String]
    
    //The current Position of Witchie in the levelArray
    @Published var position: Int
    
    //Model responsible for handling the business (game) rules
    let game = Game()
    
    //Manager for the Analytics
    let firebaseManager = FirebaseManager()
    
    @Published var witchImage: String
    
    init() {
        self.patch = UserSettings.currentLevel.patch
        self.levelNumber = UserSettings.currentLevel.level
        self.levelArray = LevelModel.getLevels(chapter: UserSettings.currentLevel.patch)[UserSettings.currentLevel.level].levelMap
        self.position = LevelModel.getIndexes(of: person, in: LevelModel.getLevels(chapter: UserSettings.currentLevel.patch)[UserSettings.currentLevel.level].levelMap)[0]
        self.witchImage = PatchModel().getPatchAssets(patch: UserSettings.currentLevel.patch, images: [ImageAsset.TILE_WITCH_LEFT, ImageAsset.WITCHIE_GARDEN_LEFT])
    }
    
    var levelGrid: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 15, maximum: 150), spacing: 0), count: LevelModel.getLevels(chapter: patch)[levelNumber].levelOffset)
    }
    
    //Original map state
    var model: LevelModel {
        LevelModel.getLevels(chapter: patch)[levelNumber]
    }
    
    //position of the marks
    var levelSpotsIndex: [Int] {
        LevelModel.getIndexes(of: spot, in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)
    }
    
    var startPosition: Int {
        LevelModel.getIndexes(of: person, in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)[0]
    }
    
    //map size
    var offset: Int {
        model.levelOffset
    }
    
    //types of map elements
    let box = ContentComponent.BOX
    let grass = ContentComponent.GRASS
    let person = ContentComponent.PERSON
    let wall = ContentComponent.WALL
    let spot = ContentComponent.SPOT
    let empty = ContentComponent.EMPTY
    
    //special map elements
    let crate = ContentComponent.CRATE
    let hole = ContentComponent.HOLE
    
    public let images = (1...11).map { String(format: "frame-%d", $0) }.map {Image($0)}
    public let patch1animation = (1...9).map { String(format: "GIF_CAUDRON_%d", $0)}.map {Image($0)}
    public let patch2animation = (1...21).map { String(format: "BLOSSOM_%d", $0)}.map {Image($0)}
    
    //MARK: Functions
    
    //defines the background depending on the patch
    func getPatchBackground() -> AnyView {
        let backgrounds = [AnyView(DenBackground()), AnyView( GardenBackground())]
        let patch = patch
        guard patch >= 1 && patch <= backgrounds.count else {
            return AnyView(Text("default_background"))
        }
        return backgrounds[patch - 1]
    }
    
    //aqui n entendi <- é pra pegar os assets da tela pos nivel
    
    func getAnimation(patch: Int) -> AnimatingImage{
        if patch == 1 {
            return AnimatingImage(images: patch1animation, interval: 0.05)
        }else if patch == 2{
            return AnimatingImage(images: patch2animation, interval: 0.07, shouldLock: true)
        }
        return AnimatingImage(images: patch2animation, interval: 0.07, shouldLock: true)
    }
    
    func refreshGame() {
        playerMovements = 0
        levelArray = model.levelMap
        position = startPosition
    }
    
    func directionChanged(from gesture: CGSize) -> GestureDirection {
        return game.getDirection(from: gesture)
    }
    
    //sends the type of movement to the model and receives a type of movement
    func gestureEnded() {
        if !isGameOver {
            if direction == .down{
                showOnboarding2 = false
                game.defineMovement(levelArray: levelArray, actualPosition: position, offset: offset, spotsIndex: levelSpotsIndex) { movement in
                    self.makeMovement(movement: movement, offset: self.offset)
                }
                showOnboarding = false
            }else if direction == .up{
                game.defineMovement(levelArray: levelArray, actualPosition: position, offset: -offset, spotsIndex: levelSpotsIndex) { movement in
                    self.makeMovement(movement: movement, offset: -self.offset)
                }
            }else if direction == .left{
                witchImage = PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_LEFT, ImageAsset.WITCHIE_GARDEN_LEFT])
                game.defineMovement(levelArray: levelArray, actualPosition: position, offset: -1, spotsIndex: levelSpotsIndex) { movement in
                    self.makeMovement(movement: movement, offset: -1)
                }
            }else if direction == .right{
                witchImage = PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_RIGHT, ImageAsset.WITCHIE_GARDEN_RIGHT])
                if patch == 2 && levelNumber == 0 && showOnboarding{
                    showOnboarding2 = true
                }
                game.defineMovement(levelArray: levelArray, actualPosition: position, offset: 1, spotsIndex: levelSpotsIndex) { movement in
                    self.makeMovement(movement: movement, offset: 1)
                }
            }
            self.gestureOffset = .zero
            self.direction = .none
        }
    }
    
    //changes the positions of the array depending on the answer of the model
    func makeMovement(movement: Movement, offset: Int) {
        switch movement {
            
        case .witchToHole:
            refreshGame()
            
        case .witchWalking:
            levelArray.swapAt(position + offset, position)
            position = position + offset
            if levelArray[position + offset] != grass {
                if (levelArray[position + offset] == hole){
                    makeMovement(movement: .witchToHole, offset: offset)
                }else{
                    playerMovements += 1
                }
            } else {
                makeMovement(movement: movement, offset: offset)
            }
            
        case .crateToGrass:
            levelArray[position] = grass
            levelArray[position + offset] = person
            levelArray[position + offset + offset] = crate
            position = position + offset
            playerMovements += 1
            
        case .boxToMark:
            levelArray[position] = grass
            levelArray[position + offset] = person
            levelArray[position + offset + offset] = box
            position = position + offset
            playerMovements += 1
            //MARK: should play sound
            if !isLevelCompleted(platesPosition: levelSpotsIndex){
                fxPlayerManager.playBoxInMarkFX(patch: patch)
            }
            
        case .boxToGrass:
            levelArray[position] = grass
            levelArray[position + offset] = person
            levelArray[position + offset + offset] = box
            position = position + offset
            playerMovements += 1
            
        case .crateToHole:
            levelArray[position] = grass
            levelArray[position + offset] = person
            position = position + offset
            playerMovements += 1
            
        default:
            print("movimento invalido")
            //MARK: tocar som de movimento invalido
        }
        
        if isLevelCompleted(platesPosition: levelSpotsIndex){
            didLevelCompleted()
        }
    }
    
    func didLevelCompleted(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            self.showEnding.toggle()
            self.fxPlayerManager.stopSound()
            self.audioPlayerManager.audioPlayer?.volume = 0.07
        }
        self.isGameOver.toggle()
        showReviewPrompt()
        firebaseManager.level_completed(patch: self.patch, level: self.levelNumber, playerMovements: self.playerMovements, timePlayed: self.timePlayed, refreshes: self.refreshes)
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
    
    func showReviewPrompt() {

    }
    
    func isLevelCompleted(platesPosition: [Int]) -> Bool{
        return platesPosition.allSatisfy{levelArray[$0] == box}
    }
    
    func getGridAsset(num: Int) -> AnyView {
        
        if levelArray[num] == wall{
            return AnyView(Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_BRICK, ImageAsset.GARDEN_BRICK]))
                .resizable()
                .scaledToFill())
        }
        else if levelArray[num] == grass{
            return AnyView(Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_GRASS, ImageAsset.TILE_GARDEN]))
                .resizable()
                .scaledToFill())
        }
        else if levelArray[num] == hole{
            return AnyView(Image(ImageAsset.TILE_HOLE)
                .resizable()
                .scaledToFill())
        }
        else if levelArray[num] == crate{
            return AnyView(Image(ImageAsset.TILE_BUSH)
                .resizable()
                .scaledToFill())
        }
        else if levelArray[num] == spot{
            return AnyView(Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_SPOT, ImageAsset.TILE_MAGICAL_SOIL]))
                .resizable()
                .scaledToFill())
        }
        
        // this only happens when a cauldron is in the marked place
        // Talvez isso não deveria estar assim (?), talvez deveria ser uma função na LevelViewModel <- VIROU ;)
        else if levelArray[num] == box && levelSpotsIndex.contains(num) {
            if !isGameOver{
                return AnyView(Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_CAULDRON, ImageAsset.TILE_BLOSSOMED]))
                    .resizable()
                    .scaledToFill())
            }else{
                return AnyView(getAnimation(patch: patch))
            }
        }
        else if levelArray[num] == box{
            return AnyView(Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.TILE_EMPTY_CAULDRON, ImageAsset.TILE_EMPTY_PLANT]))
                .resizable()
                .scaledToFill())
        }
        else if levelArray[num] == person{
            return AnyView(Image(witchImage)
                .resizable()
                .scaledToFill())
        }
        else if levelArray[num] == empty{
            return AnyView(Image(ImageAsset.EMPTY)
                .resizable()
                .scaledToFill())
        } else {
            return AnyView(Image(""))
        }
    }
    
    func getNextButton() -> AnyView{
        // if it is the last level OR if it is level 9 from the patch 1 AND the user has not been redirected yet
        // se for jogador antigo vai redirecionar
        if ((levelNumber == LevelModel.getLevels(chapter: patch).count - 1) || (levelNumber == 8 && patch == 1 && !UserSettings.hasSeenNewChapter == true)) {
            return (
                AnyView(
                    NavigationLink(destination: PatchSelectorView()) {
                        Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                        .simultaneousGesture(TapGesture().onEnded({
                            UserSettings.isNotFirstTime[self.patch - 1] = true
                            UserSettings.hasSeenNewChapter = true
                            self.defaultsManager.setSeenChapter(value: true)
                        }))
                )
            )
        }
        else {
            return(
                AnyView(
                    Button{
                        self.refreshGame()
                        self.levelNumber += 1
                        UserSettings.currentLevel.level = self.levelNumber
                        self.refreshGame()
                        self.isGameOver.toggle()
                        self.showEnding.toggle()
                    } label: {
                        Image(PatchModel().getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                )
            )
        }
    }
}
    

