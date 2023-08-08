//
//  Onboarding5.swift
//  witchie
//
//  Created by Guilherme Souza on 06/08/23.
//

import SwiftUI

struct Onboarding5: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width)/2)
                HStack {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width * 0.35)
                    Image("test")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height * 0.55)
                }
            }
            VStack {
                VStack  (spacing: UIScreen.main.bounds.height * 0.07) {
                    Text(ContentComponent.TEXT_ONBOARDING5)
                        .frame(width: UIScreen.main.bounds.width * 0.84)
                        .padding(.vertical, UIScreen.main.bounds.height * 0.15)
                        .background(Color(ColorAsset.LIGHT_BEGE))
                        .cornerRadius(20)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.regular, size: 20))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                }
                .padding(.top, UIScreen.main.bounds.height * 0.15)
                Spacer()
                HStack {
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width * 0.84)
                    NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                        HStack {
                            Image(systemName: "arrow.forward").font(.custom(ContentComponent.regular, size: 40))
                                .underline()
                                .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                .padding(.bottom, -10)
                        }
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
        //.navigationBarBackButtonHidden(true)
    }
}

struct Onboarding5_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding5()
    }
}
