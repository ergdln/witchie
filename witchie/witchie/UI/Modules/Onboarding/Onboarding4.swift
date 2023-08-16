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
                        NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                        .padding(.trailing, safeDimensionManager.dimensions.width * 0.12)
                    }
                    Text(ContentComponent.TEXT_ONBOARDING4)
                        .frame(width: safeDimensionManager.dimensions.width * 0.84)
                        .padding(.vertical, safeDimensionManager.dimensions.height * 0.07)
                        .background(Color(ColorAsset.LIGHT_BEGE))
                        .cornerRadius(20)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: 20))
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
                        .aspectRatio(contentMode: .fit)
                        .frame(width: safeDimensionManager.dimensions.width * 1.015, height: safeDimensionManager.dimensions.height * 0.41)
                    Spacer()
                        .frame(width: safeDimensionManager.dimensions.width - (safeDimensionManager.dimensions.width * 0.9)/2)
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
