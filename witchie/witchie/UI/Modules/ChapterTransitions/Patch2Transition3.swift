//
//  Transition1.swift
//  witchie
//
//  Created by egln on 13/09/23.
//

import SwiftUI

struct Patch2Transition3: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack{
            //MARK: ILUSTRATIONS
            ZStack{
                VStack{
                    Spacer()
                    ZStack{
                        Image(ImageAsset.Transition2_Asset3)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width)
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: TEXT BOX
            VStack(){
                ChapterTransitionTextBox(TransitionText: ContentComponent.CHAPTER2_ENTRY_TEXT3, textBoxBackgroundImage: ImageAsset.DIALOGUE_GREENRECTANGLE_PATCH2)
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
                        UserSettings.currentLevel.patch = 2
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
            
        }.background(Color(ColorAsset.BACKGROUND_GREEN))
            .ignoresSafeArea()
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
    }
}

struct Patch2Transition3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
