//
//  ContentComponent.swift
//  witchie
//
//  Created by egln on 20/07/23.
//

import Foundation
import SwiftUI

struct ContentComponent {
    
    //MARK: FONT RELATED VARIABLES
    static let CARD_FONT = 0.021
    static let STEP_COUNTER_FONT = 0.018
    static let BOREL_REGULAR = "Borel-Regular"
    
    //MARK: ONBOARDING TEXTS
    //Ei, você aí, vamos ser diretos porque tô sem tempo pra conversa fiada.\n\n Eu sou a Witchie.
    static let TEXT_ONBOARDING1 = String(localized: "text_onboarding1")
    //Alguém encheu meu covil de feitiços irritantes e eles estão sabotando a Vassorilda.
    static let TEXT_ONBOARDING2 = String(localized: "text_onboarding2")
    //Felizmente, sou muito esperta e sei como resolver: basta colocar meus caldeirões em cima das marcas mágicas para neutralizá-las.
    static let TEXT_ONBOARDING3 = String(localized: "text_onboarding3")
    //O problema é que, com a\n Vassorilda sabotada, eu\n não consigo me mover\ndireito, por isso preciso da\n sua ajuda.
    static let TEXT_ONBOARDING4 = String(localized: "text_onboarding4")
    //Eaí, pronto para o desafio?
    static let TEXT_ONBOARDING5 = String(localized: "text_onboarding5")
    
    //MARK: ABOUT US TEXTS
    static let ABOUT_US = String(localized: "about_us")
    static let WWDC2023_WINNER = String(localized: "wwdc2023_winner")
    static let CREATOR = String(localized: "creator")
    static let ERNESTO = "Ernesto Gonçalves"
    static let GAME_DESIGNER = String(localized: "game_designer")
    static let LUCAS = "Lucas Souza"
    static let DESIGNER = String(localized: "designer")
    static let BRUNA = "Bruna Avellar"
    static let DEV = String(localized: "dev")
    static let GUILHERME = "Guilherme Souza"
    static let BARRETO = "João Pedro Barreto"
    static let THALES = "Thales Fraga"
    
    //MARK: EMOJIS
    static let BOX = "📦"
    static let GRASS = "⬜️"
    static let PERSON = "🙋🏿"
    static let WALL = "⬛️"
    static let SPOT = "🔯"
    static let EMPTY = "🟫"
    
    //future map elements
    static let CRATE = "🗄️"
    static let HOLE = "🕳️"
    
    //MARK: OTHERS
    static let LEVEL = String(localized: "level")
    static let LEVELS = String(localized: "levels")
    static let BACK = String(localized: "back")
    static let BEGIN = String(localized: "begin_game")
//    static let BACK_SYSTEM = "<"
    static let BACK_SYSTEM = Image(systemName: "chevron.backward")
    static let JUMP = String(localized: "jump")
    
    //MARK: TEXTS BETWEEN LEVELS
    
    //EPISODE 1
    //Caramba, olha como você foi rápido! Tenho certeza que, se continuar assim, a Vassorilda volta ao normal rapidinho. Vamo pra próxima sala?
    static let LEVEL_DIALOGUE_1 = String(localized: "level_dialogue_1")
    //Subindo e descendo a escadinha... Acho que encontrar os padrões é a chave!
    static let LEVEL_DIALOGUE_2 = String(localized: "level_dialogue_2")
    //É… Não foi tão direto quanto antes, mas até que você não foi mal.
    static let LEVEL_DIALOGUE_3 = String(localized: "level_dialogue_3")
    //Viu que era só parar e pensar ao invés de empurrar tudo de uma vez? A pressa é inimiga da perfeição!
    static let LEVEL_DIALOGUE_4 = String(localized: "level_dialogue_4")
    //Parecia óbvio, né? Pois tá aí a lição de nunca confiar em ninguém!!!
    static let LEVEL_DIALOGUE_5 = String(localized: "level_dialogue_5")
    //Parecia óbvio, né? Pois tá aí a lição de nunca confiar em ninguém!!!
    static let LEVEL_DIALOGUE_6 = String(localized: "level_dialogue_6")
    //Eita como demora pra ouvir minhas dicas...
    static let LEVEL_DIALOGUE_7 = String(localized: "level_dialogue_7")
    //Olha, não vem jogar a culpa em mim não, viu! Minha filha que insistiu pra eu chamar o namorado arquiteto dela, porque ele tinha umas ideias “modernas” para as minhas salas… Qual o problema da velha e clássica teia de aranha?!?!
    static let LEVEL_DIALOGUE_8 = String(localized: "level_dialogue_8")
    //Não é porque parece simples que é! Fica sempre ligado que as paredes são suas amigas.
    static let LEVEL_DIALOGUE_9 = String(localized: "level_dialogue_9")
    //Esse padrão foi interessante, acho que vale a pena memorizar...
    static let LEVEL_DIALOGUE_10 = String(localized: "level_dialogue_10")
    //Tô começando a achar que botaram esses círculos em lugares complicadinhos de propósito...
    static let LEVEL_DIALOGUE_11 = String(localized: "level_dialogue_11")
    //Meus parabéns, viu? Essa aí era um divisor de águas. Se chegasse até aqui, talvez tenha algum futuro nesse trabalho…
    static let LEVEL_DIALOGUE_12 = String(localized: "level_dialogue_12")
    //Eu nem sabia que eu tinha tanto caldeirão assim, acho que vou fazer um bazar.
    static let LEVEL_DIALOGUE_13 = String(localized: "level_dialogue_13")
    //Eita quanta correria pra lá e pra cá, chega tô tontinha!
    static let LEVEL_DIALOGUE_14 = String(localized: "level_dialogue_14")
    //Eu acho que nunca vi ninguém apertar tanto aquele botão, deve tá até emperrado agora.
    static let LEVEL_DIALOGUE_15 = String(localized: "level_dialogue_15")
    //Ok, essa foi um respiro de tranquilidade depois desses últimas salas tão intensas.
    static let LEVEL_DIALOGUE_16 = String(localized: "level_dialogue_16")
    //Falei cedo demais.
    static let LEVEL_DIALOGUE_17 = String(localized: "level_dialogue_17")
    //Como é que cabe tanto caldeirão numa sala só?????
    static let LEVEL_DIALOGUE_18 = String(localized: "level_dialogue_18")
    //Esses círculos não acabam nunca? Minhas costas não aguentam mais.
    static let LEVEL_DIALOGUE_19 = String(localized: "level_dialogue_19")
    //Nessa daqui eu não vou nem te culpar pela demora. Inclusive, se precisar de um psicólogo tenho indicações.
    static let LEVEL_DIALOGUE_20 = String(localized: "level_dialogue_20")
    //Depois dessa eu vou me APOSENTAR!
    static let LEVEL_DIALOGUE_21 = String(localized: "level_dialogue_21")
    
}
