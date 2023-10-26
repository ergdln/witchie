//
//  AudioPlayerManager.swift
//  witchie
//
//  Created by Guilherme Souza on 26/07/23.
//

/*import SwiftUI
import AVFoundation
import Combine

class FXPlayerManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    let audioSession = AVAudioSession()
    @Published var soundOn: Bool = DefaultsManager.shared.getSoundPreference() // Adicionar @Published para notificar mudanças no soundOn

    func playLevelCompletedFX(patch:Int){
        let sound = Bundle.main.path(forResource: patch == 1 ? "winFantasia" : "winBanjo", ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.numberOfLoops = 1
        audioPlayer?.volume = 1.0
        audioPlayer?.play()
    }
    
    func playBoxInMarkFX(patch:Int){
        let sound = Bundle.main.path(forResource: patch == 1 ? "cauldron-right-place" : "plant-right-place", ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.numberOfLoops = 1
        audioPlayer?.volume = patch == 1 ? 1.0 : 0.8
        audioPlayer?.play()
        DispatchQueue.main.asyncAfter(deadline: patch == 1 ? .now() + 0.3 : .now() + 0.5) {
            self.stopSound()
        }
    }
    
    func playButtonFX(){
        let sound = Bundle.main.path(forResource: "buttonPush", ofType: "mp3")
        audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        audioPlayer?.numberOfLoops = 1
        audioPlayer?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.stopSound()
        }
    }
    
    

    func stopSound() {
        audioPlayer?.stop()
    }
}
*/
