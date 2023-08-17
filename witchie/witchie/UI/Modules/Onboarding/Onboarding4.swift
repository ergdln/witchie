//
//  Onboarding4.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Onboarding4: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack {
            VStack {
                VStack  (spacing: safeDimensionManager.dimensions.height * 0.07) {
                    HStack {
                        Spacer()
                        NavigationLink(destination: LevelView(patch: 1, levelNumber: 0)) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                        .padding(.trailing, safeDimensionManager.dimensions.width * 0.12)
                    }
                    Text(ContentComponent.TEXT_ONBOARDING4)
                        .padding(safeDimensionManager.dimensions.height * 0.04)
                        .background(
                            Image(ImageAsset.DIALOGUE_45)
                                .resizable()
                                .scaledToFill())
                        .frame(width: (safeDimensionManager.dimensions.height * 0.38)/0.94, height: safeDimensionManager.dimensions.height * 0.38)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: safeDimensionManager.dimensions.height * 0.023))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                }
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 0.84)
                    NextButton(color: ColorAsset.MAIN_WHITE) {
                        funcToDo()
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
        .overlay {
            VStack {
                Spacer()
                    .frame(width: safeDimensionManager.dimensions.width - (safeDimensionManager.dimensions.width)/2)
                HStack {
                    Image(ImageAsset.ONBOARDING4_WITCHIE)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width * 0.85)
                }
            }
        }
    }
}

struct Onboarding4_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
