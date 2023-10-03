//
//  Level2ViewModel.swift
//  Witchie
//
//  Created by ditthales on 29/09/23.
//  
//

import SwiftUI

// MARK: Variables to watch mark as Published. ViewModel also calls API/Core Data

final class Level2ViewModel: ObservableObject {
    
    @ObservedObject var defaultsManager = DefaultsManager.shared
    
    @Published var patch: Int
    @Published var levelNumber: Int
    
    @Published var levelArray: [String]
    
    @Published var showEnding: Bool = false
    
    @Published var showOnboarding: Bool = UserSettings.currentLevel.showOnboarding ?? false
    @Published var showOnboarding2: Bool = false
    
    
    init() {
        self.patch = UserSettings.currentLevel.patch
        self.levelNumber = UserSettings.currentLevel.level
        self.levelArray = LevelModel.getLevels(chapter: UserSettings.currentLevel.patch)[UserSettings.currentLevel.level].levelMap
    }
    
    @Published var playerMovements: Int = 0
    @Published var refreshes: Int = 0
    
    @Published var isGameOver = false
    
    @Published var witchImage: String = ImageAsset.TILE_WITCH_LEFT
    
    var levelGrid: [GridItem] {
        Array(repeating: GridItem(.flexible(minimum: 15, maximum: 150), spacing: 0), count: LevelModel.getLevels(chapter: patch)[levelNumber].levelOffset)
    }
    
    var model: LevelModel {
        LevelModel.getLevels(chapter: patch)[levelNumber]
    }
    
    var levelSpotsIndex: [Int] {
        LevelModel.getIndexes(of: spot, in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)
    }
    
    
    
    let box = ContentComponent.BOX
    let grass = ContentComponent.GRASS
    let person = ContentComponent.PERSON
    let wall = ContentComponent.WALL
    let spot = ContentComponent.SPOT
    let empty = ContentComponent.EMPTY
    
    //future map elements
    let crate = ContentComponent.CRATE
    let hole = ContentComponent.HOLE
    
    
    public let images = (1...11).map { String(format: "frame-%d", $0) }.map { Image($0) }
    public let patch1animation = (1...9).map { String(format: "GIF_CAUDRON_%d", $0)}.map {Image($0)}
    public let patch2animation = (1...21).map { String(format: "BLOSSOM_%d", $0)}.map {Image($0)}
    
    
    
    func getPatchBackground() -> AnyView {
        let backgrounds = [AnyView(DenBackground()), AnyView( GardenBackground())]
        let patch = patch
        guard patch >= 1 && patch <= backgrounds.count else {
            return AnyView(Text("default_background"))
        }
        return backgrounds[patch - 1]
    }
    
    func getPatchAssets(patch: Int, images: [String]) -> String {
        guard patch >= 1 && patch <= images.count else {
            return "default_image" //caso seja um valor de patch inválido
        }
        return images[patch - 1] //subtrai 1 do patch para corresponder ao índice do array
    }
    
    func getAnimation(patch: Int) -> AnimatingImage{
        if patch == 1 {
            return AnimatingImage(images: patch1animation, interval: 0.05)
        }else if patch == 2{
            return AnimatingImage(images: patch2animation, interval: 0.07, shouldLock: true)
        }
        return AnimatingImage(images: patch2animation, interval: 0.07, shouldLock: true)
    }
    
    func refreshGame() {
        
    }
    
    func getGridAsset(num: Int) -> AnyView {
        // Os assets deveriam estar na PatchModel
        // Esse If/Else pode virar uma função na LevelViewModel
        if model.levelMap[num] == wall{
            return AnyView(Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_BRICK, ImageAsset.GARDEN_BRICK]))
                .resizable()
                .scaledToFill())
            
        }
        else if model.levelMap[num] == grass{
            return AnyView(Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_GRASS, ImageAsset.TILE_GARDEN]))
                .resizable()
                .scaledToFill())
        }
        else if model.levelMap[num] == hole{
            return AnyView(Image(ImageAsset.TILE_HOLE)
                .resizable()
                .scaledToFill())
        }
        else if model.levelMap[num] == crate{
            return AnyView(Image(ImageAsset.TILE_BUSH)
                .resizable()
                .scaledToFill())
        }
        else if model.levelMap[num] == spot{
            return AnyView(Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_SPOT, ImageAsset.TILE_MAGICAL_SOIL]))
                .resizable()
                .scaledToFill())
        }
        // this only happens when a cauldron is in the marked place
        // Talvez isso não deveria estar assim (?), talvez deveria ser uma função na LevelViewModel
        else if model.levelMap[num] == box && levelSpotsIndex.contains(num) {
            if !isGameOver{
                return AnyView(Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_CAULDRON, ImageAsset.TILE_BLOSSOMED]))
                    .resizable()
                    .scaledToFill())
            }else{
                return AnyView(getAnimation(patch: patch))
            }
            
        }
        else if model.levelMap[num] == box{
            return AnyView(Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_EMPTY_CAULDRON, ImageAsset.TILE_EMPTY_PLANT]))
                .resizable()
                .scaledToFill())
        }
        else if model.levelMap[num] == person{
            return AnyView(Image(witchImage)
                .resizable()
                .scaledToFill())
        }
        else if model.levelMap[num] == empty{
            return AnyView(Image(ImageAsset.EMPTY)
                .resizable()
                .scaledToFill())
        } else {
            return AnyView(Image(""))
        }
    }
    
    func getNextButton() -> AnyView{
        if (levelNumber < LevelModel.getLevels(chapter: patch).count - 1) {
            if (levelNumber == 8 && patch == 1){
                if UserSettings.hasSeenNewChapter == true {
                    
                    return (
                        AnyView(
                            Button{
                                self.refreshGame()
                                self.levelNumber += 1
                                self.refreshGame()
                                self.isGameOver.toggle()
                                self.showEnding.toggle()
                            }
                            label: {
                                Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        )
                    )
                }
                else {
                    
                    return(
                        AnyView(
                            NavigationLink(destination: PatchSelectorView()) {
                                Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
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
            }
            else {
                return(
                    AnyView(
                        Button{
                            self.refreshGame()
                            self.levelNumber += 1
                            self.refreshGame()
                            self.isGameOver.toggle()
                            self.showEnding.toggle()
                        } label: {
                            Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    )
                )
            }
        }
        else {
            return(
                AnyView(
                    NavigationLink(destination: StartGameView()) {
                        Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                )
            )
        }

    }
    
    
}
