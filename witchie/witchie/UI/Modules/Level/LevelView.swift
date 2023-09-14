//
//  LevelView.swift
//  witchie
//
//  Created by ditthales on 21/07/23.
//

import SwiftUI
import AVFoundation
import FirebaseAnalytics

struct LevelView: View{
    
    @State public var soundOn = true
    @EnvironmentObject public var audioPlayerManager: AudioPlayerManager
    @State var levelNumber: Int
    @State var levelModel: [LevelModel]
    
    var patch: Int
    
    @State var levelGrid: [GridItem]
    @State var levelSpotsIndex: [Int]
    @State var levelActualPosition: Int
    @State var levelStartPosition: Int
    
    //MARK: VARIABLES

    @State public var isGameOver = false
    @State public var gestureOffset: CGSize = .zero
    @State public var direction: Direction = .none
    @State public var playerMovements: Int = 0
    @State public var timePlayed: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State public var refreshes: Int = 0
    
    //Onboarding things
    @State var showOnboarding: Bool
    public let images = (1...11).map { String(format: "frame-%d", $0) }.map { Image($0) }
    
    @StateObject var safeDimensionManager = DimensionManager.shared
    @ObservedObject var defaultsManager = DefaultsManager.shared
    
    enum Direction {
        case none, up, down, left, right
    }
    
    @State var showOnboarding2 = false
    
    //witch first image
    @State var witchImage: String
    
    //Rename de map elements
    let box = ContentComponent.BOX
    let grass = ContentComponent.GRASS
    let person = ContentComponent.PERSON
    let wall = ContentComponent.WALL
    let spot = ContentComponent.SPOT
    let empty = ContentComponent.EMPTY
    
    //future map elements
    let crate = ContentComponent.CRATE
    let hole = ContentComponent.HOLE
    
    init(patch: Int, levelNumber: Int, showOnboarding: Bool = false) {
        self.patch = patch
        
        self._levelNumber = State(initialValue: levelNumber)
        self._levelModel = State(initialValue: LevelModel.getLevels(chapter: patch))
        self._levelGrid = State(initialValue: Array(repeating: GridItem(.flexible(minimum: 15, maximum: 150), spacing: 0), count: LevelModel.getLevels(chapter: patch)[levelNumber].levelOffset))
        self._levelSpotsIndex = State(initialValue: LevelModel.getIndexes(of: spot, in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap))
        self._levelStartPosition = State(initialValue: LevelModel.getIndexes(of: person, in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)[0])
        self._levelActualPosition = State(initialValue: LevelModel.getIndexes(of: person, in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)[0])
        self._witchImage = State(initialValue: ImageAsset.WITCH_LEFT)
        self._showOnboarding = State(initialValue: showOnboarding)
        
        
    }
    
    @Environment(\.dismiss) public var dismiss
    
    //MARK: THE GAME VIEW
    var body: some View{
        ZStack{
            if true {//safeDimensionManager.orientation == .portrait{
                if patch == 1 {
                    Image(ImageAsset.BACKGROUND)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                } else {
                    GardenBackground()
                }
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center) {
                        if UserSettings.isNotFirstTime{
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
                                UserSettings.isNotFirstTime = true
                            }))
                        }
                        Spacer()
                        Text("\(ContentComponent.LEVEL) \(levelNumber + 1)")
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 32))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .padding(.bottom, -20)
                        Spacer()
                        SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_WHITE)
                    }
                    Spacer()
                    HStack {
                        StepCounter(imageName: ImageAsset.COUNTER, playerMovements: playerMovements, type: .levelView)
                        Spacer()
                        Button(action:{
                            refreshGame()
                            refreshes += 1
                        }){
                            Image(ImageAsset.REFRESH_BUTTON)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 38)
                        }.disabled(isGameOver)
                    }
                    LazyVGrid(columns: levelGrid, spacing: 0){
                        ForEach((0...levelModel[levelNumber].levelMap.count-1), id: \.self) { num in
                            Group{
                                if levelModel[levelNumber].levelMap[num] == wall{
                                    Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_BRICK, ImageAsset.GARDEN_BRICK]))
                                        .resizable()
                                        .scaledToFill()
                                        
                                }
                                else if levelModel[levelNumber].levelMap[num] == grass{
                                    Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_GRASS, ImageAsset.TILE_GARDEN]))
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == hole{
                                    Image(ImageAsset.TILE_HOLE)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == crate{
                                    Image(ImageAsset.TILE_BUSH)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == spot{
                                    Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_SPOT, ImageAsset.TILE_MAGICAL_SOIL]))
                                        .resizable()
                                        .scaledToFill()
                                }
                                //this only happens when a cauldron is in the mark place
                                else if levelModel[levelNumber].levelMap[num] == box && levelSpotsIndex.contains(num) {
                                    Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_CAULDRON, ImageAsset.TILE_BLOSSOMED]))
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == box{
                                    Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_EMPTY_CAULDRON, ImageAsset.TILE_EMPTY_PLANT]))
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == person{
                                    Image(witchImage)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == empty{
                                    Image(ImageAsset.EMPTY)
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                        }
                    }
                    .padding(.top, 20)
                    Spacer()
                }.frame(width: safeDimensionManager.dimensions.width * 0.8, height: safeDimensionManager.dimensions.height * 0.8)
                    .navigationBarBackButtonHidden(true)
                
                //MARK: Changes the screen when coming from onboarding
                if showOnboarding{
                    ZStack{
                        if patch == 1{
                            Color.black
                                .opacity(0.4)
                            AnimatingImage(images: images, interval: 0.1)
                                .frame(height: safeDimensionManager.dimensions.height / 2)
                                .padding(.leading, safeDimensionManager.dimensions.width * 0.13)
                        }else if patch == 2 && showOnboarding2{
                            Color.black
                                .opacity(0.4)
                            VStack(spacing: 0){
                                AnimatingImage(images: images, interval: 0.1)
                                    .frame(height: safeDimensionManager.dimensions.height / 4)
                                    .padding(.leading, safeDimensionManager.dimensions.width * 0.11)
                                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.2)
                                
                                Text(ContentComponent.ANIMATION_TEXT)
                                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                    .font(.custom(ContentComponent.BOREL_REGULAR, size: 18))
                                    .padding(.top, 15)
                                    .padding(.horizontal, 30)
                                    .background(.purple.opacity(0.4))
                                
                            }
                        }
                        
                    }
                }
                
                //MARK: Changes the screen when the game is over
                if isGameOver{
                    ZStack{
                        Image(ImageAsset.BACKGROUND)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                        VStack(alignment: .center, spacing: 10) {
                            Spacer()
                            HStack{
                                Button{
                                    dismiss()
                                }label: {
                                    Text(ContentComponent.BACK_SYSTEM).foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 24))
                                        .padding(.bottom, -15)
                                        .opacity(0)
                                }.disabled(true)
                                Spacer()
                                Text("\(ContentComponent.LEVEL) \(levelNumber + 1)")
                                    .font(.custom(ContentComponent.BOREL_REGULAR, size: 32))
                                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                    .padding(.bottom, -20)
                                Spacer()
                                SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.WHITE)
                            }
                            .padding(.horizontal, safeDimensionManager.dimensions.width * 0.1)
                            Spacer()
                            ZStack{
                                Text(levelModel[levelNumber].levelDialogue)
                                    .padding(safeDimensionManager.dimensions.height * 0.04)
                                    .background(
                                        Image(ImageAsset.DIALOGUE_RECTANGLE)
                                            .resizable()
                                            .scaledToFill()
                                    )
                                    .frame(width: (safeDimensionManager.dimensions.height * 0.5) / 1.23, height: safeDimensionManager.dimensions.height * 0.5)
                                    .multilineTextAlignment(.center)
                                    .font(.custom(ContentComponent.BOREL_REGULAR, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT * 0.98))
                                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                            }
                            //.border(.green)
                            Spacer()
                            if (levelNumber < LevelModel.getLevels(chapter: 1).count - 1) {
                                Button{
                                    refreshGame()
                                    levelNumber += 1
                                    refreshGame()
                                    isGameOver.toggle()
                                }
                            label: {
                                Image(ImageAsset.NEXT_BUTTON_DIALOGUE)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 0.43)
                            }
                            }
                            else {
                                NavigationLink(destination: StartGameView()) {
                                    Image(ImageAsset.NEXT_BUTTON_DIALOGUE)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 0.43)
                                }                        .simultaneousGesture(TapGesture().onEnded({
                                    UserSettings.isNotFirstTime = true
                                }))
                            }
                        }
                        .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                    }
                }
            }
            else{
                 Text("EITA VIROU LANDSCAPE")
            }
        }
        .onChange(of: levelNumber) { newValue in
            Analytics.logEvent(AnalyticsEventLevelStart, parameters: [AnalyticsParameterLevelName: "\(patch): \(newValue + 1)"])
        }
        .onAppear(){
            Analytics.logEvent(AnalyticsEventLevelStart, parameters: [AnalyticsParameterLevelName: "\(patch): \(levelNumber + 1)"])
            witchImage = getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_LEFT, ImageAsset.WITCHIE_GARDEN_LEFT])
            
        }
        //Analytics.logEvent(AnalyticsEventLevelStart, parameters: [AnalyticsParameterLevel: levelNumber])
        .onReceive(timer) { _ in
            if (!isGameOver){
                timePlayed += 1
            }
        }
        .ignoresSafeArea()
        //MARK: New sliding game controls
#if os(iOS)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.gestureOffset = gesture.translation
                    self.direction = self.getDirection(from: gesture.translation)
                }
                .onEnded { gesture in
                    if (!isGameOver){
                        if direction == .down{
                            showOnboarding2 = false
                            defineMoviment(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset)
                            showOnboarding = false
                        }else if direction == .up{
                            defineMoviment(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset * -1)
                        }else if direction == .left{
                            witchImage = getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_LEFT, ImageAsset.WITCHIE_GARDEN_LEFT])
                            defineMoviment(actualPosition: levelActualPosition, offset: -1)
                        }else if direction == .right{
                            witchImage = getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_RIGHT, ImageAsset.WITCHIE_GARDEN_RIGHT])
                            if patch == 2 && levelNumber == 0 && showOnboarding{
                                showOnboarding2 = true
                            }
                            defineMoviment(actualPosition: levelActualPosition, offset: 1)
                        }
                        self.gestureOffset = .zero
                        self.direction = .none
                        
                    }
                }
        )
#endif
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


