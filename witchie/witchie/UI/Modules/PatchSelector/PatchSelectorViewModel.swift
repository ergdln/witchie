//
//  PatchSelectorViewModel.swift
//  witchie
//
//  Created by ditthales on 12/09/23.
//  
//

import SwiftUI

// MARK: Variables to watch mark as Published. ViewModel also calls API/Core Data

final class PatchSelectorViewModel: ObservableObject {
    @Published var soundOn = true
    
    @ObservedObject var safeDimensionManager = DimensionManager.shared
    
    @Published var cardInformations = [
        PatchInformations(name: ContentComponent.DEN, colors: PatchInformations.Colors(
            color1: Color(red: 23/255, green: 10/255, blue: 44/255),
            color2: Color(red: 60/255, green: 20/255, blue: 111/255),
            bgColor: Color(red: 41/255, green: 27/255, blue: 83/255)), image: Image(ImageAsset.WITCH_PATCH_CARD)
        ),
        PatchInformations(name: ContentComponent.GARDEN, colors: PatchInformations.Colors(
            color1: Color(red: 0/255, green: 26/255, blue: 20/255),
            color2: Color(red: 27/255, green: 105/255, blue: 85/255),
            bgColor: Color(red: 13/255, green: 56/255, blue: 46/255)), image: Image(ImageAsset.VASE_FULL)
        )
    ]
    
    func shouldDisable(patch: Int) -> Bool{
        if patch == 1{
            return false
        }else{
            return UserSettings.records[patch-1]![8] == 0
        }
    }
    
    func getStars(patch: Int) -> Int{
        if UserSettings.records[patch]![20] != 0{
            return 3
        }else if UserSettings.records[patch]![14] != 0{
            return 2
        }else if UserSettings.records[patch]![8] != 0{
            return 1
        }else{
            return 0
        }
    }
    
    func getScreenSize() -> DimensionsConfig{
        
        let cardSize = CGSize(width: safeDimensionManager.dimensions.width * 0.7641, height: safeDimensionManager.dimensions.height * 0.665)
        
        let starCointainerSize = CGSize(width: cardSize.width * 0.7684, height: cardSize.height * 0.1174)
        
        let starsSize = CGSize(width: starCointainerSize.height * 0.65, height: starCointainerSize.height * 0.65)
        
        return DimensionsConfig(card: cardSize,
                                stars: starsSize,
                                starContainer: starCointainerSize)
    }
}
