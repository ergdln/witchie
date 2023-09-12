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
    
    func shouldDisable(patch: Int) -> Bool{
        if patch == 1{
            return false
        }else{
            return UserSettings.records[patch-1]![8] == 0
        }
    }
}
