//
//  Transition1.swift
//  witchie
//
//  Created by egln on 13/09/23.
//

import SwiftUI

struct Patch2Transition1: View {
    //var funcToDo: () -> ()
    @StateObject var safeDimensionManager = DimensionManager.shared
    var body: some View {
        ZStack{
            //MARK: BRUXINHA, TEXTO, OBJETOS
            ZStack{
                VStack{
                    Spacer()
                    ZStack{
                        //Cauldron Stack
                        HStack (alignment: .bottom) {
                            Image(ImageAsset.CAULDRON_ONBOARDING)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:safeDimensionManager.dimensions.height * 0.15, height: safeDimensionManager.dimensions.height * 0.15)
                            
                            Image(ImageAsset.CAULDRON_ONBOARDING)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: safeDimensionManager.dimensions.height * 0.15, height: safeDimensionManager.dimensions.height * 0.15)
                        }
                        HStack (alignment: .bottom) {
                            Image(ImageAsset.WITCH_START)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: safeDimensionManager.dimensions.height * 0.3, height: safeDimensionManager.dimensions.height * 0.3)
                                .rotationEffect(.degrees(13.5))
                        }
                    }
                }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: CAIXA DE TEXTO
            VStack(){
                Group{
                    Text(ContentComponent.TEXT_ONBOARDING1)
                        .padding(safeDimensionManager.dimensions.height * 0.04)
                        .background(
                            Image(ImageAsset.DIALOGUE_123)
                                .resizable()
                                .scaledToFill())
                        .frame(width: (safeDimensionManager.dimensions.height * 0.38)/0.94, height: safeDimensionManager.dimensions.height * 0.38)
                        .multilineTextAlignment(.center)
                        .font(.custom(ContentComponent.BOREL_REGULAR, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT))
                        .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                }.padding(.top, safeDimensionManager.dimensions.height * 0.15)
                Spacer()
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
            //MARK: BOTÕES
            HStack{
                Spacer()
                VStack(spacing: 0){
                    NavigationLink(destination: LevelView(patch: 1, levelNumber: 0, showOnboarding: true)) {
                        JumpButton(color: ColorAsset.MAIN_WHITE)
                    }
                    .padding(.top, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.07)
                    
                    Spacer()
                        .frame(height: safeDimensionManager.dimensions.height * 0.75)
                    
                    NextButton(color: ColorAsset.MAIN_WHITE) {
                        // funcToDo()
                    }
                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.06)
                    .padding(.trailing, safeDimensionManager.dimensions.width * 0.1)
                }
            }.frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            
        }.background(Color(ColorAsset.MAIN_PURPLE))
            .ignoresSafeArea()
            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
            .border(.green)
    }
}

struct Patch2Transition1_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
