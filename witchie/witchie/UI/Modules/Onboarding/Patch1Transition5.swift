//
//  Onboarding5.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Patch1Transition5: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack{
            //MARK: ILUSTRATIONS
            ZStack{
                VStack{
                    Spacer()
                    ZStack{
                        Image(ImageAsset.Transition1_Asset5)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width)
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: TEXT BOX
            VStack(){
                ChapterTransitionTextBox(TransitionText: ContentComponent.TEXT_ONBOARDING5, textBoxBackgroundImage: ImageAsset.DIALOGUE_123)
                Spacer()
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: BUTTONS
                HStack{
                    Spacer()
                    VStack(spacing: 0){
                        //HIDDEN SKIP BUTTON
                        NavigationLink(destination: LevelView(patch: 1, levelNumber: 0, showOnboarding: true)) {
                            JumpButton(color: ColorAsset.MAIN_WHITE)
                        }
                        .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                        .padding(.trailing, safeDimensionManager.dimensions.width * 0.07)
                        .hidden()
                            
                            Spacer()
                                .frame(height: safeDimensionManager.dimensions.height * 0.75)
                            
                        //NEXT BUTTON
                        NavigationLink(destination: LevelView(patch: 1, levelNumber: 0, showOnboarding: true)) {
                            Group{
                                HStack {
                                    Image(systemName: "arrow.forward").font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                                        .underline()
                                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                        .padding(.bottom, -10)
                                }
                            }.padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
                            .padding(.trailing, safeDimensionManager.dimensions.width * 0.1)
                        }
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                
            }.background(Color(ColorAsset.MAIN_PURPLE))
                .ignoresSafeArea()
                .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
    }
}

struct Onboarding5_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//ZStack {
//    VStack {
//        Spacer()
//            .frame(width: safeDimensionManager.dimensions.width - (safeDimensionManager.dimensions.width)/2)
//        HStack {
//            Spacer()
//                .frame(width: safeDimensionManager.dimensions.width * 0.35)
//            Image("test")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: safeDimensionManager.dimensions.width * 2, height: safeDimensionManager.dimensions.height * 0.55)
//        }
//    }
//    VStack {
//        VStack  (spacing: safeDimensionManager.dimensions.height * 0.07) {
//            Text(ContentComponent.TEXT_ONBOARDING5)
//                .padding(safeDimensionManager.dimensions.height * 0.04)
//                .background(
//                    Image(ImageAsset.DIALOGUE_45)
//                        .resizable()
//                        .scaledToFill())
//                .frame(width: (safeDimensionManager.dimensions.height * 0.31)/0.77, height: safeDimensionManager.dimensions.height * 0.31)
//                .multilineTextAlignment(.center)
//                .font(.custom(ContentComponent.BOREL_REGULAR, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT))
//                .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
//        }
//        .padding(.top, safeDimensionManager.dimensions.height * 0.15)
//        Spacer()
//        HStack {
//            Spacer()
//                .frame(width: safeDimensionManager.dimensions.width * 0.84)
//            NavigationLink(destination: LevelView(patch: 1, levelNumber: 0, showOnboarding: true)) {
//                HStack {
//                    Image(systemName: "arrow.forward").font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
//                        .underline()
//                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
//                        .padding(.bottom, -10)
//                }
//            }
//            .padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
//            .padding(.trailing, safeDimensionManager.dimensions.width * 0.1)
//        }
//    }
//}
//.ignoresSafeArea()
//.background(Color(ColorAsset.MAIN_PURPLE))
//.frame(maxWidth: .infinity, maxHeight: .infinity)
//.edgesIgnoringSafeArea(.all)
