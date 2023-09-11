//
//  PatchSelectorView.swift
//  witchie
//
//  Created by ditthales on 04/09/23.
//

import SwiftUI

struct PatchSelectorView: View {
    @State private var soundOn = true
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @Environment(\.dismiss) private var dismiss
    
    var safeDimensionManager = DimensionManager.shared

    var body: some View {
        ZStack {
            Color(red: 248/255, green: 239/255, blue: 235/255)
                .ignoresSafeArea()
            VStack (spacing: 0) {
                HStack (alignment: .center) {
                    BackButton(color: ColorAsset.MAIN_PURPLE, backStyle: ContentComponent.BACK) {
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
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 90, maximum: 300), spacing: 0), count: 2), spacing: 30) {
                        ForEach(Array(1..<UserSettings.records.count + 1), id: \.self) { patch in
                            NavigationLink(destination: LevelSelectorView(patch: patch)) {
                                VStack(alignment: .center, spacing: 0){
                                    Text("\(patch)").font(.custom(ContentComponent.BOREL_REGULAR, size: 35))
                                        .padding(.bottom, -30)
                                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                                        .opacity(shouldDisable(patch: patch) ? 0.2 : 1)
                                        ZStack{
                                            Image(ImageAsset.CAULDRON_FULL)
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.8)
                                                .opacity(shouldDisable(patch: patch) ? 0.2 : 1)
                                        }
                                }
                            }.disabled(shouldDisable(patch: patch))
                        }
                    }
                    .frame(width: safeDimensionManager.dimensions.width * 0.8)
                    .onAppear{
                    }
                }.scrollIndicators(.hidden)
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear{
        }
    }
    
    
    func shouldDisable(patch: Int) -> Bool{
        if patch == 1{
            return false
        }else{
            return UserSettings.records[patch-1]![8] == 0
        }
    }
}

struct PatchSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        PatchSelectorView()
    }
}
