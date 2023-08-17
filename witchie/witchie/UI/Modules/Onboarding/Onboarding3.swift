//
//  Onboarding3.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Onboarding3: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack {
            Color(ColorAsset.MAIN_PURPLE)
                .ignoresSafeArea()
            ZStack {
                
            }
            .overlay {
                VStack {
                    Spacer()
                        .frame(height: safeDimensionManager.dimensions.height * 1.25)
                    HStack {
                        Image(ImageAsset.CAULDRON_ONBOARDING_BIG)
                        Spacer()
                            .frame(width: safeDimensionManager.dimensions.width * 0.25)
                    }
                }
            }
            .overlay {
                VStack {
                    Spacer()
                        .frame(height: safeDimensionManager.dimensions.height * 0.03)
                    HStack {
                        Image(ImageAsset.BUBBLE)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: safeDimensionManager.dimensions.width * 0.28)
                        Spacer()
                            .frame(width: safeDimensionManager.dimensions.width * 0.07)
                    }
                }
            }
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: safeDimensionManager.dimensions.width * 0.2)
                        Image(ImageAsset.BUBBLE)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: safeDimensionManager.dimensions.width * 0.28)
                    }
                    Spacer()
                        .frame(height: safeDimensionManager.dimensions.height * 0.7)
                }
            }
            VStack {
                VStack (spacing: safeDimensionManager.dimensions.height * 0.07) {
                    HStack (alignment: .center) {
                        Spacer()
                        NavigationLink(destination: LevelView(patch: 1, levelNumber: 0, showOnboarding: true)) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, safeDimensionManager.dimensions.height * 0.03)
                        .padding(.trailing, safeDimensionManager.dimensions.height * 0.03)
                    }
                    Text(ContentComponent.TEXT_ONBOARDING2)
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
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: safeDimensionManager.dimensions.height * 0.4)
                HStack {
                    Spacer()
                    NextButton(color: ColorAsset.MAIN_WHITE) {
                        funcToDo()
                    }
                    .padding(.trailing, safeDimensionManager.dimensions.height * 0.03)
                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.03)
                }
            }
        }
        .overlay {
            VStack {
                Spacer()
                    .frame(height: safeDimensionManager.dimensions.height * 0.04)
                HStack {
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 0.5)
                    Image(ImageAsset.BUBBLE)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: safeDimensionManager.dimensions.height * 0.06)
                }
            }
        }
    }
}

struct Onboarding3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
