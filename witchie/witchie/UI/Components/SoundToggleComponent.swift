//
//  SoundToggleComponent.swift
//  witchie
//
//  Created by Guilherme Souza on 28/07/23.
//

import SwiftUI

struct SoundToggleComponent: View {
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

struct SoundToggleComponent_Previews: PreviewProvider {
    static var previews: some View {
        SoundToggleComponent(soundOn: .constant(true), audioPlayerManager: .init())
    }
}
