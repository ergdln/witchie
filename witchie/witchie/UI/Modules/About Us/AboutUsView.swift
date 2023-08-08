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
    
    var body: some View {
        ZStack {
            Color(ColorAsset.MAIN_PURPLE)
                .ignoresSafeArea()
            VStack {
                HStack (alignment: .center) {
                    BackButton(color: ColorAsset.MAIN_WHITE) {
                        dismiss()
                    }
                    Spacer()
                    SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_WHITE)
                }
                .padding(.horizontal, 32.0)

                Spacer()
                VStack(spacing: 8.0) {
                    Text("Sobre Nós")
                        .font(.custom(ContentComponent.regular, size: 40))
                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                    Text("Jogo vencedor do Swift Student Challenge 2023 🥇")
                        .font(.custom(ContentComponent.regular, size: 20))
                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 48.0)
                Spacer()
                VStack(spacing: 8.0) {
                    HStack {
                        Text("Ernesto Gonçalves")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text("Creator")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text("João Pedro Barreto")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text("Dev")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text("Bruna Avellar")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text("Designer")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text("Lucas Souza")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text("Game designer")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text("Guilherme Souza")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text("Dev")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                    }
                    HStack {
                        Text("Thales Fraga")
                            .font(.custom(ContentComponent.regular, size: 16))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .fixedSize()
                        Rectangle()
                            .frame(height: 1.0)
                            .foregroundColor(Color(ColorAsset.BAR_PURPLE))
                        Text("Dev")
                            .font(.custom(ContentComponent.regular, size: 16))
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
                                .frame(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.25)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Image(ImageAsset.PLAY_WITCHIE)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.15)
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
