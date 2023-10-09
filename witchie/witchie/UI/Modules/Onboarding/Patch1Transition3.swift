//
//  Onboarding3.swift
//  witchie
//
//  Created by Guilherme Souza on 15/08/23.
//

import SwiftUI

struct Patch1Transition3: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack{
            //MARK: ILUSTRATIONS
            ZStack{
                VStack{
                    Spacer()
                    ZStack{
                        Image(ImageAsset.Transition1_Asset3)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 2)
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: TEXT BOX
            VStack(){
                ChapterTransitionTextBox(TransitionText: ContentComponent.TEXT_ONBOARDING3, textBoxBackgroundImage: ImageAsset.DIALOGUE_123)
                Spacer()
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: BUTTONS
            HStack{
                Spacer()
                VStack(spacing: 0){
                    //SKIP BUTTON
                    NavigationLink(destination: LevelView()) {
                        JumpButton(color: ColorAsset.MAIN_WHITE)
                    }
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        UserSettings.currentLevel.patch = 1
                        UserSettings.currentLevel.level = 0
                        UserSettings.currentLevel.showOnboarding = true
                    }))
                    .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.07)
                    
                    Spacer()
                        .frame(height: safeDimensionManager.dimensions.height * 0.75)
                    
                    //NEXT BUTTON
                    NextButton(color: ColorAsset.MAIN_WHITE) {
                        funcToDo()
                    }
                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.1)
                }
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
        }.background(Color(ColorAsset.MAIN_PURPLE))
            .ignoresSafeArea()
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
    }
}

struct Onboarding3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
