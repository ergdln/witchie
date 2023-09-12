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
    
    @Published var cardInformations = [
        PatchInformations(name: "Covil", colors: PatchInformations.Colors(
            color1: Color(red: 23/255, green: 10/255, blue: 44/255),
            color2: Color(red: 60/255, green: 20/255, blue: 111/255),
            bgColor: Color(red: 41/255, green: 27/255, blue: 83/255)), image: Image("IMAGE-PATCH1")
        ),
        PatchInformations(name: "Jardim", colors: PatchInformations.Colors(
            color1: Color(red: 0/255, green: 26/255, blue: 20/255),
            color2: Color(red: 27/255, green: 105/255, blue: 85/255),
            bgColor: Color(red: 13/255, green: 56/255, blue: 46/255)), image: Image("VASE-FULL")
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
}
