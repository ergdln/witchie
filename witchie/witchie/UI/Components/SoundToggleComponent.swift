//
//  SoundToggleComponent.swift
//  witchie
//
//  Created by Guilherme Souza on 28/07/23.
//

import SwiftUI

struct SoundToggleComponent: View {
    @StateObject var defaultsManager = DefaultsManager.shared
    @Binding var soundOn: Bool
    @ObservedObject var audioPlayerManager: AudioPlayerManager
    var color: String
    var body: some View {
        
        Button{
            soundOn.toggle()
            defaultsManager.setSoundPreference(value: soundOn)
        }label: {
            if soundOn{
                if color == ColorAsset.MAIN_PURPLE{
                    Image(ImageAsset.SOUND_ON_PURPLE)
                        .resizable()
                }else{
                    Image(ImageAsset.SOUND_ON_WHITE)
                }
                
            }else{
                if color == ColorAsset.MAIN_PURPLE{
                    Image(ImageAsset.SOUND_OFF_PURPLE)
                        .resizable()
                }else{
                    Image(ImageAsset.SOUND_OFF_WHITE)
                }
                
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
        .onAppear{
            soundOn = defaultsManager.getSoundPreference()
        }
    }
}

struct SoundToggleComponent_Previews: PreviewProvider {
    static var previews: some View {
        SoundToggleComponent(soundOn: .constant(false), audioPlayerManager: .init(), color: ColorAsset.MAIN_WHITE)
    }
}
