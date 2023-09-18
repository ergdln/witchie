//
//  ContentView.swift
//  witchie
//
//  Created by egln on 20/07/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @StateObject var audioPlayerManager = AudioPlayerManager()
    @StateObject var dimensionManager = DimensionManager.shared
    
    var body: some View {
        GeometryReader { geo in
            Patch2TransitionView()
            //AnythingCanFlyRandomly()
            //OnboardingView()
            //StarPath(color: Color(ColorAsset.BAR_PURPLE))
            //StartGameView()
            //LevelView(patch: 2, levelNumber: 0, showOnboarding: true)
                .onAppear {
                    //Ler o tamanho do dispositivo
                    dimensionManager.dimensions = geo.size
                    
                    // Criar o AVAudioPlayer no início do jogo
                    audioPlayerManager.gameStarted()
                    
                    
                    //Isso aqui foi como consegui fazer pra os usuários não perderem seu progresso:
                    //Primeiro ele recebe os dados da chave que já existia "CurrentLevel"
                    LevelCompleted.isCompleted[1] = UserDefaults.standard.array(forKey: "CurrentLevel") as? [Bool] ?? LevelCompleted.isCompleted[1]
                    //Depois checa conflitos (especifico pro patch 1)
                    if LevelCompleted.isCompleted[1]!.count < LevelModel.patchOne().count{
                        let add = LevelModel.patchOne().count - LevelCompleted.isCompleted[1]!.count
                        for _ in (0...add){
                            LevelCompleted.isCompleted[1]!.append(false)
                        }
                        UserDefaults.standard.set(LevelCompleted.isCompleted[1], forKey: "CurrentLevel")
                    }
                    
                    //pega se é a primeira vez do usuário
                    UserSettings.isNotFirstTime = UserDefaults.standard.bool(forKey: "isNotFirstTime")
                    
                    //aqui começamos a salvar os recordes, a lógica é a mesma lá de cima, com a diferença que agora o patch 1 vai usar a chave "records1" o que facilita nossa vida depois
                    
                    for i in (1...UserSettings.records.count){
                        UserSettings.records[i] = UserDefaults.standard.array(forKey: "records\(i)") as? [Int] ?? UserSettings.records[i]
                        if UserSettings.records[i]!.count < LevelModel.getLevels(chapter: i).count {
                            let add = LevelModel.getLevels(chapter: i).count - UserSettings.records[i]!.count
                            for _ in (0...add){
                                UserSettings.records[i]!.append(0)
                            }
                        }
                        UserDefaults.standard.set(UserSettings.records[i], forKey: "records\(i)")
                    }
                    
                    
                    
                    
                    
                    
                }
                .onChange(of: geo.size, perform: { newValue in
                    dimensionManager.dimensions = geo.size
                })
                .environmentObject(audioPlayerManager)
                .preferredColorScheme(.dark)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
