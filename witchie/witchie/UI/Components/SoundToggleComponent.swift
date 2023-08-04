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
        
        Button{
            soundOn.toggle()
        }label: {
            if soundOn{
                Image(ImageAsset.SOUND_ON)
                    .resizable()
            }else{
                Image(ImageAsset.SOUND_OFF)
                    .resizable()
            }
        }
        .frame(width: 33, height: 26)
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
