//
//  Onboarding2.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Onboarding2: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack {
            HStack {
                Image(ImageAsset.SPOT_CLEAN)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: safeDimensionManager.dimensions.width * 0.92)
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width - (safeDimensionManager.dimensions.width * 0.3)/2)
            }
            VStack {
                VStack  (spacing: safeDimensionManager.dimensions.height * 0.07) {
                    HStack (alignment: .center) {
                        Spacer()
                            .frame(width: safeDimensionManager.dimensions.width * 0.84)
                        NavigationLink(destination: LevelView(patch: 1, levelNumber: 0)) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                        .padding(.trailing, safeDimensionManager.dimensions.width * 0.14)
                    }
                    Text(ContentComponent.TEXT_ONBOARDING2)
                        .padding(safeDimensionManager.dimensions.height * 0.04)
                        .background(
                            Image(ImageAsset.DIALOGUE_123)
                                .resizable()
                                .scaledToFill())
                        .frame(width: (safeDimensionManager.dimensions.height * 0.31)/0.77, height: safeDimensionManager.dimensions.height * 0.31)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                        //.border(.green)
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
        .ignoresSafeArea()
        .background(Color(ColorAsset.MAIN_PURPLE))
        .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
        .overlay {
            VStack {
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height * 0.35)
                HStack (alignment: .bottom) {
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 0.1)
                    Image(ImageAsset.BROOM)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: safeDimensionManager.dimensions.height * 0.44)
                }
            }
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
        }
    }
}

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
