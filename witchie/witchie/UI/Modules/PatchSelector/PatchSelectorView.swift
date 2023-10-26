//
//  PatchSelectorView.swift
//  witchie
//
//  Created by ditthales on 04/09/23.
//

import SwiftUI

struct PatchSelectorView: View {
    @ObservedObject var viewModel = PatchSelectorViewModel()
    //@EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    //@StateObject var fxPlayerManager = FXPlayerManager()
    @Environment(\.dismiss) private var dismiss
    
    let lockColor1 = Color(red: 54/255, green: 54/255, blue: 54/255)
    let lockColor2 = Color(red: 82/255, green: 82/255, blue: 82/255)

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
                    
                    //SoundToggleComponent(soundOn: $viewModel.soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_PURPLE)
                }
                .padding([.horizontal,.top], 32.0)
                
                Text(ContentComponent.CHAPTER).font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                    .padding(.top, 20)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: Array(repeating: GridItem(.flexible(minimum: viewModel.screenSize.card.height * 1.1, maximum: 2000), spacing: 0), count: 1), spacing: 30){
                        ForEach(Array(1..<UserSettings.records.count + 1), id: \.self) { patch in
                            NavigationLink(destination: UserSettings.records[patch]![0] == 0 ? AnyView(viewModel.getOnboarding(patch: patch)) : AnyView(LevelSelectorView(patch: patch))) {
                                PatchCard(gradientColor1: viewModel.shouldDisable(patch: patch) ? lockColor1 : viewModel.cardInformations[patch - 1].colors.color1,
                                          gradientColor2: viewModel.shouldDisable(patch: patch) ? lockColor2 : viewModel.cardInformations[patch - 1].colors.color2,
                                          bgColor: viewModel.cardInformations[patch - 1].colors.bgColor,
                                          name: viewModel.cardInformations[patch - 1].name,
                                          stars: viewModel.getStars(patch: patch),
                                          image: viewModel.shouldDisable(patch: patch) ? viewModel.cardInformations[patch - 1].lockedImage : viewModel.cardInformations[patch - 1].image,
                                          patch: patch,
                                          disable: viewModel.shouldDisable(patch: patch))
                            }.disabled(viewModel.shouldDisable(patch: patch))
                                .simultaneousGesture(TapGesture().onEnded({ _ in
                                    //fxPlayerManager.playButtonFX()
                                }))
                        }
                    }
                    .padding(.horizontal)
                }
            }
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
