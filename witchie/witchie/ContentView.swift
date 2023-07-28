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
            .onAppear {
                // Criar o AVAudioPlayer no início do jogo
                audioPlayerManager.setupAudioPlayer()
                audioPlayerManager.playSound()
        }
            .environmentObject(audioPlayerManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
