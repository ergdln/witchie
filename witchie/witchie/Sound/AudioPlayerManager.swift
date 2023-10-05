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
    @ObservedObject var defaultsManager = DefaultsManager.shared
    var audioPlayer: AVAudioPlayer?
    let audioSession = AVAudioSession()
    @Published var soundOn: Bool = DefaultsManager.shared.getSoundPreference() // Adicionar @Published para notificar mudanças no soundOn
    
    static var shared = AudioPlayerManager()

    func setupAudioPlayer() {
        let sound = Bundle.main.path(forResource: "LivaTheme", ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.volume = 0.07
        // TODO: Set configuration for playing even in silent mode (we need sound configurations for doing this)
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback)
//        } catch(let error) {
//            print(error.localizedDescription)
//        }
    }

    func playSound() {
        audioPlayer?.play()
    }

    func stopSound() {
        audioPlayer?.stop()
    }
    
    func gameStarted() {
        self.setupAudioPlayer()
        if defaultsManager.getSoundPreference(){
            self.playSound()
        } else {
            self.soundOn = defaultsManager.getSoundPreference()
        }
    }
}

