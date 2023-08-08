//
//  Onboarding1.swift
//  witchie
//
//  Created by Guilherme Souza on 06/08/23.
//

import SwiftUI

struct Onboarding1: View {
    var body: some View {
        //MARK: ZStack Principal
        VStack {
            VStack (spacing: UIScreen.main.bounds.height * 0.07) {
                HStack (alignment: .center) {
                    Spacer()
                    NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                        JumpButton(color: ColorAsset.MAIN_WHITE)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.06)
                    .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                }
                Text(ContentComponent.TEXT_ONBOARDING1)
                    .frame(width: UIScreen.main.bounds.width * 0.84, height: UIScreen.main.bounds.height * 0.33)
                    .padding(.vertical, UIScreen.main.bounds.height * 0.04)
                    .background(Color(ColorAsset.LIGHT_BEGE))
                    .cornerRadius(20)
                    .multilineTextAlignment(.center)
                    .font(.custom(ContentComponent.regular, size: 20))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
            }
            Spacer()
            HStack {
                Spacer()
                NextButton(color: ColorAsset.MAIN_WHITE) {
                    //addToOnboardingNumber()
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.06)
                .padding(.trailing, UIScreen.main.bounds.width * 0.1)
            }
        }
        .ignoresSafeArea()
        .background(Color(ColorAsset.MAIN_PURPLE))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .overlay {
            VStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.49)
                HStack (alignment: .bottom) {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width * 0.86)
                    Image(ImageAsset.WITCH_START)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 1.14, height: UIScreen.main.bounds.height * 0.44)
                }
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
        .overlay {
            VStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
                HStack (alignment: .bottom) {
                    Image(ImageAsset.CAULDRON_ONBOARDING)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.68, height: UIScreen.main.bounds.height * 0.29)
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.66)/2)
                }
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
    }
}

struct Onboarding1_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding1()
    }
}