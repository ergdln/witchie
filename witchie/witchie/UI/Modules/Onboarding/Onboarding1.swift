//
//  Onboarding1.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Onboarding1: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        VStack {
            VStack (spacing: safeDimensionManager.dimensions.height * 0.07) {
                HStack (alignment: .center) {
                    Spacer()
                    NavigationLink(destination: LevelView(patch: 1, levelNumber: 0, showOnboarding: true)) {
                        JumpButton(color: ColorAsset.MAIN_WHITE)
                    }
                    .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.07)
                }
                Text(ContentComponent.TEXT_ONBOARDING1)
                    .padding(safeDimensionManager.dimensions.height * 0.04)
                    .background(
                        Image(ImageAsset.DIALOGUE_123)
                            .resizable()
                            .scaledToFill())
                    .frame(width: (safeDimensionManager.dimensions.height * 0.38)/0.94, height: safeDimensionManager.dimensions.height * 0.38)
                    .multilineTextAlignment(.center)
                    .font(.custom(ContentComponent.regular, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
            }
            Spacer()
            HStack {
                Spacer()
                NextButton(color: ColorAsset.MAIN_WHITE) {
                    funcToDo()
                }
                .padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
                .padding(.trailing, safeDimensionManager.dimensions.width * 0.1)
            }
        }
        .ignoresSafeArea()
        //.border(.green)
        .background(Color(ColorAsset.MAIN_PURPLE))
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            VStack {
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height * 0.42)
                HStack (alignment: .bottom) {
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 1.05)
                    Image(ImageAsset.WITCH_START)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: safeDimensionManager.dimensions.width * 1.14, height: safeDimensionManager.dimensions.height * 0.44)
                        .rotationEffect(.degrees(13.5))
                }
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height * 0.25)
            }
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
        }
        .overlay {
            VStack {
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height * 0.8)
                HStack (alignment: .bottom) {
                    Image(ImageAsset.CAULDRON_ONBOARDING)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: safeDimensionManager.dimensions.width * 0.68, height: safeDimensionManager.dimensions.height * 0.29)
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width - (safeDimensionManager.dimensions.width * 0.3)/2)
                }
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height * 0.2)
            }
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
        }
    }
}

struct Onboarding1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
