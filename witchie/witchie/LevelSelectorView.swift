//
//  LevelSelectorView.swift
//  witchie
//
//  Created by ditthales on 25/07/23.
//

import SwiftUI
import AVFAudio

struct LevelSelectorView: View {
    @State private var soundOn = false
    @StateObject private var audioPlayerManager = AudioPlayerManager()

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                ForEach(Array(0..<LevelModel.fases().count), id: \.self) { level in
                    NavigationLink(destination: LevelView(levelNumber: level, levelModel: LevelModel.fases())) {
                        Text("Level \(level + 1)").font(.largeTitle)
                    }
                }
                SoundToggle(soundOn: $soundOn, audioPlayerManager: audioPlayerManager)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            audioPlayerManager.setupAudioPlayer()
        }
    }
}

struct LevelSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectorView()
    }
}
