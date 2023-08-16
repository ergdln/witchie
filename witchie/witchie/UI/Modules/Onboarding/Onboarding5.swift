//
//  Onboarding5.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Onboarding5: View {
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width - (safeDimensionManager.dimensions.width)/2)
                HStack {
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 0.35)
                    Image("test")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: safeDimensionManager.dimensions.width * 2, height: safeDimensionManager.dimensions.height * 0.55)
                }
            }
            VStack {
                VStack  (spacing: safeDimensionManager.dimensions.height * 0.07) {
                    Text(ContentComponent.TEXT_ONBOARDING5)
                        .padding(safeDimensionManager.dimensions.height * 0.04)
                        .background(
                            Image(ImageAsset.DIALOGUE_45)
                                .resizable()
                                .scaledToFill())
                        .frame(width: (safeDimensionManager.dimensions.height * 0.31)/0.77, height: safeDimensionManager.dimensions.height * 0.31)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: safeDimensionManager.dimensions.height * 0.023))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                }
                .padding(.top, safeDimensionManager.dimensions.height * 0.15)
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 0.84)
                    NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne(), showOnboarding: true)) {
                        HStack {
                            Image(systemName: "arrow.forward").font(.custom(ContentComponent.regular, size: 40))
                                .underline()
                                .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                .padding(.bottom, -10)
                        }
                    }
                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.1)
                }
            }
        }
        .ignoresSafeArea()
        .background(Color(ColorAsset.MAIN_PURPLE))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Onboarding5_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
