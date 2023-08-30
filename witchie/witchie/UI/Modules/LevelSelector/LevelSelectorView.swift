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
    @State var isCompleted: [Bool]
    @Environment(\.dismiss) private var dismiss
    var patch: Int
    
    init(patch: Int) {
        self.patch = patch
        self._isCompleted  = State(initialValue: LevelCompleted.isCompleted[patch]!)
    }
    
    
    var safeDimensionManager = DimensionManager.shared

    var body: some View {
        ZStack {
            Color(red: 248/255, green: 239/255, blue: 235/255)
                .ignoresSafeArea()
            VStack (spacing: 0) {
                HStack (alignment: .center) {
                    BackButton(color: ColorAsset.MAIN_PURPLE) {
                        dismiss()
                    }
                    Spacer()
                    SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_PURPLE)
                }
                .padding([.horizontal,.top], 32.0)
                Text(ContentComponent.LEVELS).font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                    .padding(.top, 20)
                ScrollView {
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30, maximum: 300), spacing: 0), count: 3), spacing: 30) {
                        ForEach(Array(0..<LevelModel.getLevels(chapter: 1).count), id: \.self) { level in
                            NavigationLink(destination: LevelView(patch: patch, levelNumber: level)) {
                                VStack(alignment: .center, spacing: 0){
                                    Text("\(level + 1)").font(.custom(ContentComponent.BOREL_REGULAR, size: 35))
                                        .padding(.bottom, -30)
                                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                                        .opacity(shouldDisable(level: level) ? 0.2 : 1)
                                    if isCompleted[level]{
                                        ZStack{
                                            Image(ImageAsset.CAULDRON_FULL)
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.8)
                                            VStack {
                                                Spacer()
                                                StepCounter(imageName: ImageAsset.BEST_RECORD, playerMovements: UserSettings.records[patch]![level], type: .levelSelectorView)
                                            }
                                        }
                                    }else{
                                        if level != 0{
                                            if isCompleted[level - 1]{
                                                Image(ImageAsset.CAULDRON_EMPTY)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .scaleEffect(0.8)
                                            }else{
                                                Image(ImageAsset.CAULDRON_EMPTY)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .scaleEffect(0.8)
                                                    .opacity(0.2)
                                            }
                                        }else{
                                            Image(ImageAsset.CAULDRON_EMPTY)
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.8)
                                        }
                                        
                                    }
                                }
                            }.disabled(shouldDisable(level: level))
                        }
                    }
                    .frame(width: safeDimensionManager.dimensions.width * 0.8)
                    .onAppear{
                        isCompleted = LevelCompleted.isCompleted[patch]!
                    }
                }.scrollIndicators(.hidden)
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear{
            print(UserSettings.records)
        }
    }
    
    
    func shouldDisable(level: Int) -> Bool{
        if level == 0{
            return false
        }else if level == LevelModel.getLevels(chapter: 1).count - 1{
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
        LevelSelectorView(patch: 1)
            .environmentObject(AudioPlayerManager())
    }
}
