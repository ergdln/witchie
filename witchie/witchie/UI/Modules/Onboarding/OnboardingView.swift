//
//  OnboardingView.swift
//  witchie
//
//  Created by Guilherme Souza on 07/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var OnboardingNumber = 1
    var body: some View {
        VStack {
            if OnboardingNumber == 1 {
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
                            addToOnboardingNumber()
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
            //aqui termina a primeira tela
            
            //aqui começa a segunda tela
            if OnboardingNumber == 2 {
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
                                addToOnboardingNumber()
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
            if OnboardingNumber == 3 {
                //MARK: ZStack Principal
                VStack (spacing: UIScreen.main.bounds.height * 0.2) {
                    VStack (spacing: UIScreen.main.bounds.height * 0.07) {
                        HStack (alignment: .center) {
                            Spacer()
                            NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                                JumpButton(color: ColorAsset.MAIN_WHITE)
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
                        NextButton(color: ColorAsset.MAIN_WHITE) {
                            addToOnboardingNumber()
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
            if OnboardingNumber == 4 {
                //MARK: ZStack Principal
                ZStack {
                    VStack {
                        VStack  (spacing: UIScreen.main.bounds.height * 0.07) {
                            HStack {
                                Spacer()
                                NavigationLink(destination: LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())) {
                                    JumpButton(color: ColorAsset.MAIN_WHITE)
                                }
                                .padding(.top, UIScreen.main.bounds.height * 0.06)
                                .padding(.trailing, UIScreen.main.bounds.width * 0.12)
                            }
                            Text(ContentComponent.TEXT_ONBOARDING4)
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
                                addToOnboardingNumber()
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
                            .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width)/2)
                        HStack {
                            Image(ImageAsset.ONBOARDING4_WITCHIE)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width * 1.015, height: UIScreen.main.bounds.height * 0.41)
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.9)/2)
                        }
                    }
                }
            }
            if OnboardingNumber == 5 {
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
        .navigationBarBackButtonHidden(true)
    }
    func addToOnboardingNumber() {
        OnboardingNumber += 1
    }
}

//struct OnboardingView_Previews: PreviewProvider {
//    static var previews: some View {
//        //OnboardingView()
//    }
//}
