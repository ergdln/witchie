//
//  AudioPlayerManager.swift
//  witchie
//
//  Created by Guilherme Souza on 26/07/23.
//

import SwiftUI
import AVFoundation
import Combine

class AudioPlayerManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var soundOn: Bool = true // Adicionar @Published para notificar mudanças no soundOn

    func setupAudioPlayer() {
        let sound = Bundle.main.path(forResource: "LivaTheme", ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.numberOfLoops = -1
    }

    func playSound() {
        audioPlayer?.play()
    }

    func stopSound() {
        audioPlayer?.stop()
    }
}

