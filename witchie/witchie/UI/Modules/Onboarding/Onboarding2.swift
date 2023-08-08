//
//  Onboarding2.swift
//  witchie
//
//  Created by Guilherme Souza on 06/08/23.
//

import SwiftUI

struct Onboarding2: View {
    var body: some View {
        //MARK: ZStack Principal
        ZStack {
            HStack {
                Image(ImageAsset.SPOT_CLEAN)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.92)
                Spacer()
                    .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.3)/2)
            }
            VStack {
                VStack  (spacing: UIScreen.main.bounds.height * 0.07) {
                    HStack (alignment: .center) {
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width * 0.84)
                        NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, UIScreen.main.bounds.height * 0.06)
                        .padding(.trailing, UIScreen.main.bounds.width * 0.14)
                    }
                    Text(ContentComponent.TEXT_ONBOARDING2)
                        .frame(width: UIScreen.main.bounds.width * 0.84)
                        .padding(.vertical, UIScreen.main.bounds.height * 0.07)
                        .background(Color(ColorAsset.LIGHT_BEGE))
                        .cornerRadius(20)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: 20))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                }
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width * 0.84)
                    NextButton(color: ColorAsset.MAIN_WHITE) {
                        //addToOnboardingNumber()
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.06)
                    .padding(.trailing, UIScreen.main.bounds.width * 0.1)
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
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.23)
                HStack (alignment: .bottom) {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width * 0.1)
                    Image(ImageAsset.BROOM)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height * 0.44)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}

struct Onboarding2_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding2()
    }
}
