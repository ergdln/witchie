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
            VStack {
                VStack (spacing: safeDimensionManager.dimensions.height * 0.07) {
                    HStack (alignment: .center) {
                        Spacer()
                            .frame(width: safeDimensionManager.dimensions.width * 0.64)
                        NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                    }
                    Text(ContentComponent.TEXT_ONBOARDING2)
                        .background(Image(ImageAsset.DIALOGUE_123))
                        .frame(width: safeDimensionManager.dimensions.width * 0.84)
                        .padding(.vertical, safeDimensionManager.dimensions.height * 0.11)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: 20))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                }
                Spacer()
                HStack {
                    Spacer()
                    NextButton(color: ColorAsset.MAIN_WHITE) {
                        funcToDo()
                    }
                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
                   .padding(.trailing, safeDimensionManager.dimensions.width * 0.45)
                }
            }
        }
        .overlay {
            VStack {
                Spacer()
                    .frame(height: safeDimensionManager.dimensions.height * 0.01)
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
