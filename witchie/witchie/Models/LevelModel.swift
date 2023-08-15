//
//  LevelModel.swift
//  witchie
//
//  Created by ditthales on 20/07/23.
//

import SwiftUI

struct LevelModel{
    
    //the width of a line
    var levelOffset: Int
    
    // the dialogue after completing a level
    var levelDialogue: String
    
    //map
    var levelMap: [String]
    
}

extension LevelModel{
    static func patchOne() -> [LevelModel]{
        return[
            // LEVEL 1
            LevelModel(
                levelOffset: 7,
                levelDialogue: "Caramba, olha como você foi rápido! Tenho certeza que, se continuar assim, a Vassorilda volta ao normal rapidinho. Vamo pra próxima sala?",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate, 🗄️ = crate, 🕳️ = hole
                    //Onboarding
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",
                     "⬛️", "🙋🏿", "⬛️", "⬜️", "⬜️", "⬛️", "🟫",
                     "⬛️", "⬜️", "⬛️", "📦", "⬜️", "⬛️", "🟫",
                     "⬛️", "⬜️", "⬛️", "🔯", "⬜️", "⬛️", "🟫",
                     "⬛️", "📦", "⬛️", "⬛️", "⬜️", "⬛️", "🟫",
                     "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬛️", "⬛️",
                     "⬛️", "🔯", "⬜️", "⬜️", "📦", "🔯", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 2
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Subindo e descendo a escadinha... Acho que encontrar os padrões é a chave!",
                levelMap: [
                    
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "📦", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "📦", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️", "⬛️",
                    "⬛️", "⬛️", "⬜️", "⬜️", "📦", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "📦", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "🙋🏿", "🔯", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 3
            LevelModel(
                levelOffset: 8,
                levelDialogue: "É… Não foi tão direto quanto antes, mas até que você não foi mal.",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",        //00 //01 //02 //03 //04 //05 //06 //07
                    "⬛️", "⬛️", "⬜️", "📦", "⬜️", "🔯", "⬛️", "⬛️",        //08 //09 //10 //11 //12 //13 //14 //15
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬛️", "⬛️", "🔯", "⬛️",        //16 //17 //18 //19 //20 //21 //22 //23
                    "⬛️", "⬜️", "⬛️", "⬛️", "🟫", "⬛️", "⬜️", "⬛️",        //24 //25 //26 //27 //28 //29 //30 //31
                    "⬛️", "⬜️", "⬛️", "🟫", "🟫", "⬛️", "⬜️", "⬛️",        //32 //33 //34 //35 //36 //37 //38 //39
                    "⬛️", "⬜️", "⬛️", "⬛️", "⬛️", "⬛️", "⬜️", "⬛️",        //40 //41 //42 //43 //44 //45 //46 //47
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",        //48 //49 //50 //51 //52 //53 //54 //55
                    "⬛️", "🔯", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",        //56 //57 //58 //59 //60 //61 //62 //63
                    "⬛️", "⬛️", "🔯", "⬜️", "📦", "🙋🏿", "⬜️", "⬛️",        //64 //65 //66 //67 //68 //69 //70 //71
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"         //72 //73 //74 //75 //76 //77 //78 //79
                    
                ]
            ),
            // LEVEL 4
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Viu que era só parar e pensar ao invés de empurrar tudo de uma vez? A pressa é inimiga da perfeição!",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",        //00 //01 //02 //03 //04 //05 //06 //07
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️",        //08 //09 //10 //11 //12 //13 //14 //15
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",        //16 //17 //18 //19 //20 //21 //22 //23
                    "⬛️", "⬛️", "⬛️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //24 //25 //26 //27 //28 //29 //30 //31
                    "⬛️", "⬛️", "⬛️", "🔯", "⬜️", "⬜️", "📦", "⬛️",        //32 //33 //34 //35 //36 //37 //38 //39
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "🔯", "⬛️",        //40 //41 //42 //43 //44 //45 //46 //47
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬛️", "⬛️",        //48 //49 //50 //51 //52 //53 //54 //55
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //56 //57 //58 //59 //60 //61 //62 //63
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "🙋🏿", "⬛️",        //64 //65 //66 //67 //68 //69 //70 //71
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"         //72 //73 //74 //75 //76 //77 //78 //79
                    
                ]
            ),
            // LEVEL 5
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Parecia óbvio, né? Pois tá aí a lição de nunca confiar em ninguém!!!",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    //Onboarding
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",
                     "⬛️", "🔯", "⬜️", "📦", "⬜️", "🔯", "⬛️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "🙋🏿", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "🔯", "📦", "⬜️", "⬜️", "⬛️", "⬛️",
                     "⬛️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 6
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Esquecesse de parar e pensar de novo, né? E olhe que ainda tava tudo simétrico pra deixar mais fácil.",
                levelMap: [
                    
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "📦", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "📦", "⬛️",
                    "⬛️", "🙋🏿", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 7
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Eita como demora pra ouvir minhas dicas...",
                levelMap: [
                    
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "🔯", "⬜️", "⬜️", "⬜️", "🔯", "⬜️", "⬛️",
                    "⬛️", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "📦", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "📦", "🔯", "⬜️", "🔯", "📦", "⬜️", "⬛️",
                    "⬛️", "🔯", "⬜️", "⬜️", "🙋🏿", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 8
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Olha, não vem jogar a culpa em mim não, viu! Minha filha que insistiu pra eu chamar o namorado arquiteto dela, porque ele tinha umas ideias “modernas” para as minhas salas… Qual o problema da velha e clássica teia de aranha?!?!",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    
                    //nivel médio
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "🔯", "⬛️", "🔯", "⬜️", "⬛️",
                     "⬛️", "📦", "⬜️", "📦", "⬜️", "📦", "⬜️", "⬛️",
                     "⬛️", "🔯", "🙋🏿", "⬜️", "⬜️", "⬜️", "📦", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬜️", "⬛️", "⬜️", "🔯", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️",
                     "⬛️", "📦", "⬜️", "📦", "⬜️", "⬜️", "🔯", "⬛️",
                     "⬛️", "🔯", "⬛️", "⬛️", "📦", "📦", "🔯", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "🔯", "⬛️", "⬛️", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫", "🟫"

                ]
            ),
            // LEVEL 9
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Não é porque parece simples que é! Fica sempre ligado que as paredes são suas amigas.",
                levelMap: [
                    
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "🔯", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬛️", "⬜️", "📦", "🙋🏿", "📦", "⬜️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 10
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Esse padrão foi interessante, acho que vale a pena memorizar...",
                levelMap: [
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    //nivel que barreto VAI CHORAR
                    "🟫", "🟫", "🟫", "🟫", "🟫", "⬛️", "⬛️", "⬛️",
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬛️",
                    "⬛️", "🙋🏿", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "📦", "📦", "📦", "📦", "📦", "📦", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "🔯", "🔯", "🔯", "🔯", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
            // LEVEL 11
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Tô começando a achar que botaram esses círculos em lugares complicadinhos de propósito...",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    //Onboarding
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                     "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬛️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "🔯", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "📦", "🙋🏿", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                     "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 12
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Meus parabéns, viu? Essa aí era um divisor de águas. Se chegasse até aqui, talvez tenha algum futuro nesse trabalho…",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫",        //00 //01 //02 //03 //04 //05 //06 //07
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬛️", "⬛️",        //08 //09 //10 //11 //12 //13 //14 //15
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //16 //17 //18 //19 //20 //21 //22 //23
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //24 //25 //26 //27 //28 //29 //30 //31
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //32 //33 //34 //35 //36 //37 //38 //39
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //40 //41 //42 //43 //44 //45 //46 //47
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //48 //49 //50 //51 //52 //53 //54 //55
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",        //56 //57 //58 //59 //60 //61 //62 //63
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "🙋🏿", "⬛️", "⬛️",        //64 //65 //66 //67 //68 //69 //70 //71
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫"         //72 //73 //74 //75 //76 //77 //78 //79
                    
                ]
            ),
            // LEVEL 13
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Eu nem sabia que eu tinha tanto caldeirão assim, acho que vou fazer um bazar.",
                levelMap: [
                    
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "📦", "⬛️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "🙋🏿", "⬜️", "📦", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬜️", "⬛️", "⬛️", "⬜️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬛️", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "📦", "⬜️", "⬛️",
                    "⬛️", "🔯", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
            // LEVEL 14
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Eita quanta correria pra lá e pra cá, chega tô tontinha!",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    //Onboarding
                     "⬛️", "⬛️", "⬛️", "⬛️", "🟫", "⬛️", "⬛️", "⬛️", "⬛️",
                     "⬛️", "🔯", "⬜️", "⬛️", "⬛️", "⬛️", "🔯", "🔯", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "📦", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "📦", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬛️", "⬜️", "🙋🏿", "⬜️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "📦", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "📦", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "🔯", "🔯", "⬛️", "⬛️", "⬛️", "⬜️", "🔯", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "🟫", "⬛️", "⬛️", "⬛️", "⬛️",
                    
                ]
            ),
            // LEVEL 15
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Eu acho que nunca vi ninguém apertar tanto aquele botão, deve tá até emperrado agora.",
                levelMap: [
                    
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                     "⬛️", "🔯", "⬛️", "🔯", "⬛️", "⬛️", "🔯", "⬛️",
                     "⬛️", "⬜️", "⬛️", "⬜️", "⬛️", "⬛️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬛️", "⬜️", "⬛️", "⬛️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",
                     "⬛️", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "📦", "⬛️",
                     "⬛️", "⬜️", "⬛️", "⬛️", "📦", "⬜️", "⬜️", "⬛️",
                     "⬛️", "⬜️", "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                     "⬛️", "🔯", "⬛️", "⬛️", "⬜️", "⬜️", "🙋🏿", "⬛️",
                     "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
            // LEVEL 16
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Ok, essa foi um respiro de tranquilidade depois desses últimas salas tão intensas.",
                levelMap: [
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "🙋🏿", "⬜️", "📦", "🔯", "⬛️",
                    "⬛️", "⬜️", "⬜️", "📦", "⬜️", "📦", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "🔯", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
            //FASE 17
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Falei cedo demais.",
                levelMap: [
                    
                    // ⬛️ = wall, 📦 = box,  🙋🏿 = person,  ⬜️ = grass,   🔯 = plate.
                    //Onboarding
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫", "🟫", "🟫",
                    "⬛️", "🔯", "⬜️", "🔯", "🔯", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️", "⬜️", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬜️", "⬛️", "⬛️", "⬛️", "⬜️", "⬛️",
                    "⬛️", "🔯", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "🙋🏿", "⬛️",
                    "⬛️", "⬛️", "⬛️", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "📦", "⬜️", "📦", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫", "🟫", "🟫", "🟫",
                    
                ]
            ),
            // FASE 18
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Como é que cabe tanto caldeirão numa sala só?????",
                levelMap: [
                    
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬛️", "🔯", "🔯", "🔯", "🔯", "🔯", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "📦", "📦", "📦", "📦", "📦", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "📦", "🙋🏿", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫"
                    
                ]
            ),
            // FASE 19
            LevelModel(
                levelOffset: 9,
                levelDialogue: "Esses círculos não acabam nunca? Minhas costas não aguentam mais.",
                levelMap: [
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "🔯", "⬜️", "⬜️", "🔯", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬛️", "⬜️", "📦", "⬜️", "⬛️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "📦", "⬜️", "⬛️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "🙋🏿", "⬜️", "📦", "🔯", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬛️", "⬜️", "📦", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬛️", "⬜️", "📦", "⬜️", "⬛️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "🔯", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
            // FASE 20
            LevelModel(
                levelOffset: 10,
                levelDialogue: "Nessa daqui eu não vou nem te culpar pela demora. Inclusive, se precisar de um psicólogo tenho indicações.",
                levelMap: [
                    
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "🟫", "🟫",
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "📦", "⬛️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬜️", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "🙋🏿", "⬜️", "⬜️", "⬜️", "⬛️", "⬜️", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬜️", "⬜️", "⬜️", "⬛️", "🔯", "⬜️", "⬜️", "⬛️",
                    "🟫", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
            // FASE 21
            LevelModel(
                levelOffset: 8,
                levelDialogue: "Depois dessa eu vou me APOSENTAR!",
                levelMap: [
                    
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️",
                    "⬛️", "🔯", "📦", "🙋🏿", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "🔯", "📦", "⬜️", "📦", "⬜️", "🔯", "⬛️",
                    "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️", "⬛️"
                    
                ]
            ),
        ]
    }
    
    static func getIndexes(of element: String, in array: [String]) -> [Int] {
        var result = [Int]()
        for (index, value) in array.enumerated() {
            if value == element {
                result.append(index)
            }
        }
        return result
    }
}
