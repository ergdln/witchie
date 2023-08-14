//
//  ContentView.swift
//  witchie
//
//  Created by egln on 20/07/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State var audioPlayer: AVAudioPlayer!
    @StateObject var audioPlayerManager = AudioPlayerManager()
    @StateObject var dimensionManager = DimensionManager.shared

    var body: some View {
        GeometryReader { geo in
            StartGameView()
                .onAppear {
                    //Ler o tamanho do dispositivo
                    dimensionManager.dimensions = geo.size
                    
                    // Criar o AVAudioPlayer no início do jogo
                    audioPlayerManager.setupAudioPlayer()
                    if UserDefaults.standard.bool(forKey: "isSoundOn"){
                        audioPlayerManager.playSound()
                    } else {
                        audioPlayerManager.soundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
                    }
                    LevelCompleted.isCompleted = UserDefaults.standard.array(forKey: "CurrentLevel") as? [Bool] ?? LevelCompleted.isCompleted
                    if LevelCompleted.isCompleted.count < LevelModel.patchOne().count{
                        let add = LevelModel.patchOne().count - LevelCompleted.isCompleted.count
                        for _ in (0...add){
                            LevelCompleted.isCompleted.append(false)
                        }
                        UserDefaults.standard.set(LevelCompleted.isCompleted, forKey: "CurrentLevel")
                    }
                    UserSettings.isNotFirstTime = UserDefaults.standard.bool(forKey: "isNotFirstTime")
                    
            }
                .onChange(of: geo.size, perform: { newValue in
                    dimensionManager.dimensions = geo.size
                })
                .environmentObject(audioPlayerManager)
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
