//
//  Level2View.swift
//  Witchie
//
//  Created by ditthales on 29/09/23.
//  
//

import SwiftUI

struct Level2View: View {
    
    @State var soundOn = true

    let patch: Int
    let level: Int
    
    @ObservedObject private var viewModel = Level2ViewModel(patch: 1, levelNumber: 0)
    
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @StateObject var dimensionManager = DimensionManager.shared
    
    @Environment(\.dismiss) public var dismiss
       
    var body: some View {
        ZStack{
            
            viewModel.getPatchBackground()
            
            VStack(alignment: .center, spacing: 10){
                
                HStack(alignment: .center) {
                    if UserSettings.isNotFirstTime[patch - 1]{
                        Button{
                            dismiss()
                        }label:{
                            Text(ContentComponent.BACK_SYSTEM).foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                .font(.custom(ContentComponent.BOREL_REGULAR, size: 24))
                                .padding(.bottom, -15)
                        }
                    }else{
                        NavigationLink(destination: StartGameView()) {
                            Text(ContentComponent.BACK_SYSTEM).foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                .font(.custom(ContentComponent.BOREL_REGULAR, size: 24))
                                .padding(.bottom, -15)
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            UserSettings.isNotFirstTime[patch - 1] = true
                        }))
                    }
                    
                    Spacer()
                    
                    Text("\(ContentComponent.LEVEL) \(viewModel.levelNumber + 1)")
                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 32))
                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                        .padding(.bottom, -20)
                    
                    Spacer()
                    
                    SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_WHITE)
                }
                
                Spacer()
                
                HStack {
                    StepCounter(imageName: ImageAsset.COUNTER, playerMovements: viewModel.playerMovements, type: .levelView)
                    Spacer()
                    Button(action:{
                        viewModel.refreshGame()
                        viewModel.refreshes += 1
                    }){
                        Image(ImageAsset.REFRESH_BUTTON)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 38)
                    }.disabled(viewModel.isGameOver)
                }
                
                Spacer()
                
                //MARK: Here goes the level grid/text pós-level
                LazyVGrid(columns: viewModel.levelGrid, spacing: 0){
                    
                    ForEach((0...viewModel.model.levelMap.count - 1), id: \.self) { num in
                        
                        viewModel.getGridAsset(num: num)
                        
                    }
                    
                }
                .padding(.top, 20)
                
                Spacer()
            }
            .frame(width: dimensionManager.dimensions.width * 0.8, height: dimensionManager.dimensions.height * 0.8)
                .navigationBarBackButtonHidden(true)
        }
        .onAppear{
            viewModel.patch = patch
            viewModel.levelNumber = level
        }
    }

}

struct Level2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
