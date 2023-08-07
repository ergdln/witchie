//
//  Onboarding3.swift
//  witchie
//
//  Created by Guilherme Souza on 06/08/23.
//

import SwiftUI

struct Onboarding3: View {
    var body: some View {
        //MARK: ZStack Principal
        VStack (spacing: UIScreen.main.bounds.height * 0.2) {
            VStack (spacing: UIScreen.main.bounds.height * 0.07) {
                HStack (alignment: .center) {
                    Spacer()
                    NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                        JumpButton(color: ColorAsset.WHITE)
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.03)
                    .padding(.trailing, UIScreen.main.bounds.width * 0.07)
                }
                Text(ContentComponent.TEXT_ONBOARDING3)
                    .frame(width: UIScreen.main.bounds.width * 0.84, height: UIScreen.main.bounds.height * 0.33)
                //.padding(.vertical, 8)
                    .background(Color(ColorAsset.LIGHT_BEGE))
                    .cornerRadius(20)
                    .multilineTextAlignment(.center)
                    .font(.custom(ContentComponent.regular, size: 20))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
            }
            Spacer()
            HStack {
                Spacer()
                NextButton(color: ColorAsset.WHITE) {
                    //addToOnboardingNumber()
                }
                .padding(.bottom, UIScreen.main.bounds.height * 0.06)
                .padding(.trailing, UIScreen.main.bounds.width * 0.1)
            }
        }
        .background(Image(ImageAsset.ONBOARDING3_BACKGROUND)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all))
        .overlay {
            VStack {
//                        Spacer()
//                            .frame(height: UIScreen.main.bounds.height)
                HStack {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width * 0.5)
                    Image(ImageAsset.BUBBLE)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: UIScreen.main.bounds.height * 0.06)
                }
            }
        }
    }
}

struct Onboarding3_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding3()
    }
}
