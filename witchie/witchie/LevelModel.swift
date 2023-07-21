//
//  LevelModel.swift
//  witchie
//
//  Created by ditthales on 20/07/23.
//

import SwiftUI

struct LevelModel{
    //where the person starts in this level
    var levelStartPosition: Int
    var levelOffset: Int
    var levelSpotsIndex: [Int]
        
    //number of columns
    var levelGrid: [GridItem]
    
    //map
    var levelMap: [String]
}

extension LevelModel{
    static func fases() -> [LevelModel]{
        return[
            LevelModel(
                levelStartPosition: 69,
                levelOffset: 8,
                levelSpotsIndex: [13, 22, 57, 66],
                levelGrid: [
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                ],
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🟨 = plate.
                    
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",        //00 //01 //02 //03 //04 //05 //06 //07
                    "⬛️", "⬛️", "⬜️", "📦", "⬜️", "🟨", "⬛️", "⬛️",        //08 //09 //10 //11 //12 //13 //14 //15
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬛️", "⬛️", "🟨", "⬛️",        //16 //17 //18 //19 //20 //21 //22 //23
                    "⬛️", "⬜️", "⬛️", "⬛️", "🟫", "⬛️", "⬜️", "⬛️",        //24 //25 //26 //27 //28 //29 //30 //31
                    "⬛️", "⬜️", "⬛️", "🟫", "🟫", "⬛️", "⬜️", "⬛️",        //32 //33 //34 //35 //36 //37 //38 //39
                    "⬛️", "⬜️", "⬛️", "⬛️", "⬛️", "⬛️", "⬜️", "⬛️",        //40 //41 //42 //43 //44 //45 //46 //47
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",        //48 //49 //50 //51 //52 //53 //54 //55
                    "⬛️", "🟨", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",        //56 //57 //58 //59 //60 //61 //62 //63
                    "⬛️", "⬛️", "🟨", "⬜️", "📦", "🙋🏿", "⬜️", "⬛️",        //64 //65 //66 //67 //68 //69 //70 //71
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"         //72 //73 //74 //75 //76 //77 //78 //79
                    
                ]
            ),
            LevelModel(
                levelStartPosition: 70,
                levelOffset: 8,
                levelSpotsIndex: [9, 35, 46, 57],
                levelGrid: [
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                ],
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🟨 = plate.
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",        //00 //01 //02 //03 //04 //05 //06 //07
                    "⬛️", "🟨", "📦", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️",        //08 //09 //10 //11 //12 //13 //14 //15
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",        //16 //17 //18 //19 //20 //21 //22 //23
                    "⬛️", "⬛️", "⬛️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //24 //25 //26 //27 //28 //29 //30 //31
                    "⬛️", "⬛️", "⬛️", "🟨", "⬜️", "⬜️", "📦", "⬛️",        //32 //33 //34 //35 //36 //37 //38 //39
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "🟨", "⬛️",        //40 //41 //42 //43 //44 //45 //46 //47
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬛️", "⬛️",        //48 //49 //50 //51 //52 //53 //54 //55
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //56 //57 //58 //59 //60 //61 //62 //63
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "🙋🏿", "⬛️",        //64 //65 //66 //67 //68 //69 //70 //71
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"         //72 //73 //74 //75 //76 //77 //78 //79
                    
                ]
            ),
            LevelModel(
                levelStartPosition: 69,
                levelOffset: 8,
                levelSpotsIndex: [9, 17, 25, 33, 41, 49, 57],
                levelGrid: [
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                    GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0),
                ],
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🟨 = plate.
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",        //00 //01 //02 //03 //04 //05 //06 //07
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬛️", "⬛️",        //08 //09 //10 //11 //12 //13 //14 //15
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //16 //17 //18 //19 //20 //21 //22 //23
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //24 //25 //26 //27 //28 //29 //30 //31
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //32 //33 //34 //35 //36 //37 //38 //39
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //40 //41 //42 //43 //44 //45 //46 //47
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //48 //49 //50 //51 //52 //53 //54 //55
                    "⬛️", "🟨", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //56 //57 //58 //59 //60 //61 //62 //63
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "🙋🏿", "⬛️", "⬛️",        //64 //65 //66 //67 //68 //69 //70 //71
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫"         //72 //73 //74 //75 //76 //77 //78 //79
                    
                ]
            ),
        ]
    }
}
