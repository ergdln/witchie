//
//  LevelSelectorView.swift
//  witchie
//
//  Created by ditthales on 25/07/23.
//

import SwiftUI
import AVFAudio

struct LevelSelectorView: View {
    @State private var soundOn = true
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @State var isCompleted: [Bool] = LevelCompleted.isCompleted

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                ForEach(Array(0..<LevelModel.patchOne().count), id: \.self) { level in
                    NavigationLink(destination: LevelView(levelNumber: level, levelModel: LevelModel.patchOne())) {
                        HStack{
                            Text("Level \(level + 1)").font(.largeTitle)
                            if isCompleted[level]{
                                Text("✅")
                            }
                        }
                    }.disabled(shouldDisable(level: level))
                }
                SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
            .onAppear{
                isCompleted = LevelCompleted.isCompleted
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func shouldDisable(level: Int) -> Bool{
        if level == 0{
            return false
        }else if level == LevelModel.patchOne().count - 1{
            if isCompleted[level - 1]{
                return false
            }
            return true
        }else{
            return !isCompleted[level - 1]
        }
    }
}

struct LevelSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectorView()
    }
}
