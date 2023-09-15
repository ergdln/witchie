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
            //MARK: BRUXINHA, TEXTO, OBJETOS
            ZStack{
                VStack{
                    Spacer()
                    ZStack{

                        
                        
                        //ilustraçoes aqui
                        
                        
                        
                        
                        
                        
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: CAIXA DE TEXTO
            VStack(){
                ChapterTransitionTextBox(TransitionText: ContentComponent.CHAPTER2_ENTRY_TEXT3)
                Spacer()
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: BOTÕES
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

struct Patch2Transition3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
