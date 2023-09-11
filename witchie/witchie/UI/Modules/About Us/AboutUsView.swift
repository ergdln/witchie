//
//  AboutUsView.swift
//  witchie
//
//  Created by egln on 03/08/23.
//

import SwiftUI

struct AboutUsView: View {
    @State private var soundOn = true
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @Environment(\.dismiss) private var dismiss
    
    var safeDimensionManager = DimensionManager.shared
    
    var body: some View {
        ZStack {
            Color(ColorAsset.MAIN_PURPLE)
                .ignoresSafeArea()
            VStack {
                HStack (alignment: .center) {
                    BackButton(color: ColorAsset.MAIN_WHITE, backStyle: ContentComponent.BACK) {
                        dismiss()
                    }
                    Spacer()
                    SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_WHITE)
                }
                .padding([.horizontal,.top], 32.0)

                Spacer()
                    //.frame(height: safeDimensionManager.dimensions.height * 0.05)
                VStack(spacing: 8.0) {
                    Text(ContentComponent.ABOUT_US)
                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                    Text(ContentComponent.WWDC2023_WINNER)
                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 20))
                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 48.0)
                Spacer()
                    .frame(height: safeDimensionManager.dimensions.height * 0.05)
                VStack(spacing: 8.0) {
                    HStack {
                        Text(ContentComponent.ERNESTO)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text(ContentComponent.CREATOR)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text(ContentComponent.BRUNA)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text(ContentComponent.DESIGNER)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text(ContentComponent.LUCAS)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text(ContentComponent.GAME_DESIGNER)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text(ContentComponent.GUILHERME)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text(ContentComponent.DEV)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text(ContentComponent.BARRETO)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text(ContentComponent.DEV)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text(ContentComponent.THALES)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text(ContentComponent.DEV)
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                }
                .padding(.horizontal, 48.0)
                Spacer()
                HStack {
                    ZStack {
                        HStack {
                            Image(ImageAsset.WITCHIE_HALF)
                                .resizable()
                                .frame(width: safeDimensionManager.dimensions.width * 0.3, height: safeDimensionManager.dimensions.height * 0.25)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Image(ImageAsset.PLAY_WITCHIE)
                                .resizable()
                                .frame(width: safeDimensionManager.dimensions.width * 0.75, height: safeDimensionManager.dimensions.height * 0.15)
                        }
                        .padding(.top, 40.0)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView().environmentObject(AudioPlayerManager())
    }
}
