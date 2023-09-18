//
//  Transition1.swift
//  witchie
//
//  Created by egln on 13/09/23.
//

import SwiftUI

struct Patch2Transition2: View {
    var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack{
            //MARK: ILUSTRATIONS
            ZStack{
                VStack{
                    Spacer()
                    ZStack{
                        Image(ImageAsset.Transition2_Asset2)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width)
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: TEXT BOX
            VStack(){
                ChapterTransitionTextBox(TransitionText: ContentComponent.CHAPTER2_ENTRY_TEXT2, textBoxBackgroundImage: ImageAsset.DIALOGUE_123)
                Spacer()
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: BUTTONS
            HStack{
                Spacer()
                VStack(spacing: 0){
                    NavigationLink(destination: LevelView(patch: 2, levelNumber: 0, showOnboarding: true)) {
                        JumpButton(color: ColorAsset.MAIN_WHITE)
                    }
                    .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.07)
                    
                    Spacer()
                        .frame(height: safeDimensionManager.dimensions.height * 0.75)
                    
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

struct Patch2Transition2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
