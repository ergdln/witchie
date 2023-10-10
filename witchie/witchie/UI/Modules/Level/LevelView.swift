//
//  Level2View.swift
//  Witchie
//
//  Created by ditthales on 29/09/23.
//  
//

import SwiftUI
import StoreKit

struct LevelView: View {
    
    @State var soundOn = true
    
    @ObservedObject private var viewModel = LevelViewModel()
    
    @EnvironmentObject var audioPlayerManager: AudioPlayerManager
    @StateObject var dimensionManager = DimensionManager.shared
    
    //Manager for the Analytics
    let firebaseManager = FirebaseManager()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var disableButton = false
    
    @Environment(\.dismiss) public var dismiss
    @Environment (\.requestReview) var requestReview
    
    var body: some View {
        ZStack {
            
            viewModel.getPatchBackground()
            
            HStack {
                
                switch viewModel.state {
                case .dialog:
                    levelDialogue
                        .onAppear{
                            if (UserSettings.records[1]![5] == 0 || UserSettings.records[2]![5] == 0) && viewModel.levelNumber == 5 {
                                requestReview()
                            }
                        }
                case .game:
                    gameView
                        .frame(width: dimensionManager.dimensions.width * 0.8, height: dimensionManager.dimensions.height * 0.6)
                }
            }
            .frame(width: dimensionManager.dimensions.width * 0.8, height: dimensionManager.dimensions.height)
            
            VStack {
                topBar
                Spacer()
            }
            .frame(width: dimensionManager.dimensions.width * 0.8)
            .padding(.top, dimensionManager.dimensions.height * 0.1)
            
            if viewModel.showOnboarding {
                coachmark
            }
            
        }
        .onAppear(){
            firebaseManager.level_started(patch: viewModel.patch, level: viewModel.levelNumber)
        }
        .onChange(of: viewModel.levelNumber, perform: { newValue in
            firebaseManager.level_started(patch: viewModel.patch, level: newValue)
        })
        .onReceive(timer) { _ in
            if (!viewModel.isGameOver){
                viewModel.timePlayed += 1
            }
        }
        .navigationBarBackButtonHidden(true)
        .gesture(
            DragGesture()
                .onChanged({ gesture in
                    viewModel.gestureOffset = gesture.translation
                    viewModel.direction = viewModel.directionChanged(from: gesture.translation)
                })
                .onEnded({ gesture in
                    viewModel.gestureEnded()
                    disableButton = false
                })
        )
    }
   
    @ViewBuilder
    var gameView: some View {
        
        VStack {
            
            Group {
                
                HStack {
                    
                    StepCounter(imageName: ImageAsset.COUNTER, playerMovements: viewModel.playerMovements, type: .levelView)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.refreshGame()
                        viewModel.refreshes += 1
                    }){
                        
                        Image(ImageAsset.REFRESH_BUTTON)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 38)
                        
                    }
                    .disabled(viewModel.isGameOver)
                }
                
                Spacer()
                
                //MARK: Here goes the level grid/text pós-level
                LazyVGrid(columns: viewModel.levelGrid, spacing: 0){
                    
                    ForEach((0...viewModel.levelArray.count - 1), id: \.self) { num in
                        
                        viewModel.getGridAsset(num: num)
                        
                    }
                    
                }
                .padding(.top, 20)
            }
        }
    }
    
    @ViewBuilder
    var levelDialogue: some View {
        
        VStack{
            
            Spacer()
            
            VStack(){
                
                Text(viewModel.model.levelDialogue)
                    .padding(dimensionManager.dimensions.height * 0.04)
                    .background(
                        Image(PatchModel().getPatchAssets(patch: viewModel.patch, images: [ImageAsset.DIALOGUE_RECTANGLE, ImageAsset.AFTER_LEVEL_CHAPTER2]))
                            .resizable()
                            .scaledToFill()
                    )
                    .frame(width: (dimensionManager.dimensions.height * 0.5) / 1.23, height: dimensionManager.dimensions.height * 0.5)
                    .multilineTextAlignment(.center)
                    .font(.custom(ContentComponent.BOREL_REGULAR, size: dimensionManager.dimensions.height * ContentComponent.CARD_FONT * 0.98))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                
                Spacer()
                
                nextButton
                    .frame(width: dimensionManager.dimensions.width, height: dimensionManager.dimensions.width * 0.43)
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        UserSettings.currentLevel.showOnboarding = false
                    }))
            }.frame(height: dimensionManager.dimensions.height * 0.8)
        }
    }
    
    @ViewBuilder
    var topBar: some View {
        
        HStack(alignment: .center) {
            
            if UserSettings.isNotFirstTime[viewModel.patch - 1] {
                Button{
                    dismiss()
                }label:{
                    Text(ContentComponent.BACK_SYSTEM).foregroundColor(Color(ColorAsset.MAIN_WHITE))
                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 24))
                        .padding(.bottom, -15)
                }
                .disabled(viewModel.isGameOver)
                .opacity(viewModel.isGameOver ? 0 : 1)
                
            } else {
                NavigationLink(destination: StartGameView()) {
                    Text(ContentComponent.BACK_SYSTEM).foregroundColor(Color(ColorAsset.MAIN_WHITE))
                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 24))
                        .padding(.bottom, -15)
                }
                .simultaneousGesture(TapGesture().onEnded({
                    UserSettings.isNotFirstTime[viewModel.patch - 1] = true
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
    }
    
    @ViewBuilder
    var coachmark: some View {
        ZStack {
            
            if viewModel.patch == 1 {
                Color.black
                    .opacity(0.4)
                AnimatingImage(images: viewModel.images, interval: 0.1)
                    .frame(height: dimensionManager.dimensions.height / 2)
                    .padding(.leading, dimensionManager.dimensions.width * 0.13)
            } else if viewModel.patch == 2 && viewModel.showOnboarding2 {
                Color.black
                    .opacity(0.4)
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    AnimatingImage(images: viewModel.images, interval: 0.1)
                        .frame(height: dimensionManager.dimensions.height / 4)
                        .padding(.leading, dimensionManager.dimensions.width * 0.11)
                        .padding(.bottom, dimensionManager.dimensions.height * 0.2)
                    
                    Spacer()
                    
                    ZStack(alignment: .bottom) {
                        
                        Rectangle().frame(width: dimensionManager.dimensions.width, height: 230).cornerRadius(40)
                        
                        HStack {
                            Text(ContentComponent.ANIMATION_TEXT)
                                .frame(width: dimensionManager.dimensions.width * 0.6)
                                .foregroundColor(Color(ColorAsset.MAIN_GREEN))
                                .font(.custom(ContentComponent.BOREL_REGULAR, size: 14))
                                .padding(.top, 15)
                                .padding(.horizontal, dimensionManager.dimensions.width * 0.1)
                                .padding(.bottom, 73)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            Image("WITCHIE-ONBOARDING-2")
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var nextButton: some View {
        // if it is the last level OR if it is level 9 from the patch 1 AND the user has not been redirected yet
        // se for jogador antigo vai redirecionar
        if ((viewModel.levelNumber == LevelModel.getLevels(chapter: viewModel.patch).count - 1) || (viewModel.levelNumber == 8 && viewModel.patch == 1 && !UserSettings.hasSeenNewChapter)) {
            NavigationLink(destination: StartGameView()) {
                Image(PatchModel().getPatchAssets(patch: viewModel.patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .simultaneousGesture(TapGesture().onEnded({
                UserSettings.isNotFirstTime[viewModel.patch - 1] = true
                UserSettings.hasSeenNewChapter = true
                viewModel.defaultsManager.setSeenChapter(value: true)
            }))
        }
        else {
            Button{
                viewModel.nextButtonAction()
            } label: {
                Image(PatchModel().getPatchAssets(patch: viewModel.patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}

struct Level2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
