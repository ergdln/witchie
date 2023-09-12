//
//  PatchSelectorView.swift
//  witchie
//
//  Created by ditthales on 04/09/23.
//

import SwiftUI

struct PatchSelectorView: View {
    @ObservedObject var viewModel = PatchSelectorViewModel()
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var safeDimensionManager = DimensionManager.shared

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
                    
                    SoundToggleComponent(soundOn: $viewModel.soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_PURPLE)
                }
                .padding([.horizontal,.top], 32.0)
                
                Text(ContentComponent.LEVELS).font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: 650, maximum: 2000), spacing: 0), count: 1), spacing: 30){
                        ForEach(Array(1..<UserSettings.records.count + 1), id: \.self) { patch in
                            NavigationLink(destination: LevelSelectorView(patch: patch)) {
                                PatchCard(gradientColor1: viewModel.cardInformations[patch - 1].colors.color1,
                                          gradientColor2: viewModel.cardInformations[patch - 1].colors.color2,
                                          bgColor: viewModel.cardInformations[patch - 1].colors.bgColor,
                                          name: viewModel.cardInformations[patch - 1].name,
                                          stars: viewModel.getStars(patch: patch),
                                          image: viewModel.cardInformations[patch - 1].image)
                                    .opacity(viewModel.shouldDisable(patch: patch) ? 0.5 : 1)
                            }.disabled(viewModel.shouldDisable(patch: patch))
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            .navigationBarBackButtonHidden()
        }
        .onAppear{
        }
    }
    
    
    
}

struct PatchSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
