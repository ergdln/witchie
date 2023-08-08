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

    var body: some View {
        StartGameView()
        //OnboardingView()
            .onAppear {
                
                // Criar o AVAudioPlayer no início do jogo
                audioPlayerManager.setupAudioPlayer()
                if UserDefaults.standard.bool(forKey: "isSoundOn"){
                    audioPlayerManager.playSound()
                } else {
                    audioPlayerManager.soundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
                }
                LevelCompleted.isCompleted = UserDefaults.standard.array(forKey: "CurrentLevel") as? [Bool] ?? LevelCompleted.isCompleted
                UserSettings.isNotFirstTime = UserDefaults.standard.bool(forKey: "isNotFirstTime")
                print(UserSettings.isNotFirstTime)
                print(UserDefaults.standard.bool(forKey: "isNotFirstTime"))
                
        }
            .environmentObject(audioPlayerManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
