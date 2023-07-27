//
//  SoundToggle.swift
//  witchie
//
//  Created by Guilherme Souza on 26/07/23.
//

import SwiftUI
import AVFoundation
import Combine

//struct SoundToggle: View {
//    @Binding var soundOn: Bool
//    @StateObject var audioPlayerManager = AudioPlayerManager()
//
//    var body: some View {
//        Toggle(soundOn ? "Sound On" : "Sound Off", isOn: $soundOn)
//            .padding()
//            .onChange(of: soundOn) { newValue in
//                if newValue {
//                    audioPlayerManager.playSound()
//                } else {
//                    audioPlayerManager.stopSound()
//                }
//            }
//    }
//}
//    class AudioPlayerManager: ObservableObject {
//        var audioPlayer: AVAudioPlayer?
//
//        func setupAudioPlayer() {
//            let sound = Bundle.main.path(forResource: "LivaTheme", ofType: "mp3")
//            audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//            audioPlayer?.numberOfLoops = -1
//            playSound()
//        }
//
//        func playSound() {
//            audioPlayer?.play()
//        }
//
//        func stopSound() {
//            audioPlayer?.stop()
//        }
//    }
struct SoundToggle: View {
    @Binding var soundOn: Bool
    @ObservedObject var audioPlayerManager: AudioPlayerManager

    var body: some View {
        Toggle("Sound \(soundOn ? "On" : "Off")", isOn: $soundOn)
            .padding()
            .onChange(of: soundOn) { newValue in
                if newValue {
                    audioPlayerManager.playSound()
                } else {
                    audioPlayerManager.stopSound()
                }
            }
    }
}

class AudioPlayerManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var soundOn: Bool = true // Adicionar @Published para notificar mudanças no soundOn

    func setupAudioPlayer() {
        let sound = Bundle.main.path(forResource: "LivaTheme", ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.numberOfLoops = -1

//         Adicionar um observador para notificar mudanças em soundOn
//        self.objectWillChange
//            .sink { [weak self] _ in
//                guard let self = self else { return }
//                if self.soundOn {
//                    self.playSound()
//                } else {
//                    self.stopSound()
//                }
//            }
//            .store(in: &cancellables)
    }

    func playSound() {
        audioPlayer?.play()
    }

    func stopSound() {
        audioPlayer?.stop()
    }

    private var cancellables: Set<AnyCancellable> = []
}

