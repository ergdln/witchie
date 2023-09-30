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
    @StateObject var defaultsManager = DefaultsManager.shared
    @StateObject var dimensionManager = DimensionManager.shared
    
    var body: some View {
        GeometryReader { geo in
            //StartGameView()
            //PatchSelectorView()
            //StartGameView()
            Level2View(patch: 1, level: 2)
                .onAppear {
                    //Ler o tamanho do dispositivo
                    dimensionManager.dimensions = geo.size
                    
                    // Criar o AVAudioPlayer no início do jogo
                    audioPlayerManager.gameStarted()
                    
                    //Carrega os valores de userdefaults no usersettings
                    defaultsManager.gameStarted() 
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
