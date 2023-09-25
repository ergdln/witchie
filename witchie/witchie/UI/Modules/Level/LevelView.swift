//
//  LevelView.swift
//  witchie
//
//  Created by ditthales on 21/07/23.
//

import SwiftUI
import AVFoundation
import StoreKit
import FirebaseAnalytics

struct LevelView: View{
    
    @State public var soundOn = true
    // Esses Managers vão para uma pasta chamada Manager
    @EnvironmentObject public var audioPlayerManager: AudioPlayerManager
    @StateObject var fxPlayerManager = FXPlayerManager()
    @State public var levelNumber: Int
    // Deveria ser chamado apenas o Nível, não o array inteiro do Model
    @State var levelModel: [LevelModel]
    
    var patch: Int
    
    @Environment(\.requestReview) var requestReview
    
    // Deveria estar na LevelModel
    // A gente deveria receber só o LevelNumber
    // Tudo isso aqui deveria ser @StateObject de uma classe que implementa @ObservableObject
    // Se os valores precisarem ser alterados, referenciamos como @ObservedObject ou @Binding
    @State var levelGrid: [GridItem]
    @State var levelSpotsIndex: [Int]
    @State var levelActualPosition: Int
    @State var levelStartPosition: Int
    
    //MARK: VARIABLES
    
    // Isso aqui fica aqui mesmo (?)
    @State public var isGameOver = false
    @State public var showEnding = false
    
    // Variáveis sobre movimentos
    // Poderiam estar em um GameManager ou algo que lide com os movimentos do jogo
    @State public var gestureOffset: CGSize = .zero
    @State public var direction: Direction = .none
    
    // Métricas, poderiam ser Structs
    @State public var playerMovements: Int = 0
    @State public var timePlayed: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State public var refreshes: Int = 0
    
    // Onboarding things
    // Deveriam estar em um PatchModel, pois são referentes à capítulos específicos
    @State var showOnboarding: Bool
    public let images = (1...11).map { String(format: "frame-%d", $0) }.map { Image($0) }
    public let patch1animation = (1...9).map { String(format: "GIF_CAUDRON_%d", $0)}.map {Image($0)}
    public let patch2animation = (1...21).map { String(format: "BLOSSOM_%d", $0)}.map {Image($0)}
    
    // Isso fica aqui mesmo
    @StateObject var safeDimensionManager = DimensionManager.shared
    @ObservedObject var defaultsManager = DefaultsManager.shared
    
    // Deveria ir pra um enum (dentro da pasta de Enum)
    enum Direction {
        case none, up, down, left, right
    }
    
    // Pode ir pro PatchModel (a partir de qual movimento mostra-se o onboarding? [não é o ideal mas])
    @State var showOnboarding2 = false
    
    // witch first image
    //
    @State var witchImage: String
    
    // Rename de map elements
    // Deveria ser um Enum
    // Muda de acordo com o Patch
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
                getPatchBackground(patch: patch, backgrounds: [AnyView(DenBackground()), AnyView( GardenBackground())])
                VStack(alignment: .center, spacing: 10) {
                    // Isso aqui deveria ser um componente TopBarComponent, com BackButton, LevelTag e SoundToggle (que agora va iser um botão de config)
                    // Deveria ter um .disable para o isGameOver
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
                        Text("\(ContentComponent.LEVEL) \(levelNumber + 1)")
                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 32))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .padding(.bottom, -20)
                        Spacer()
                        SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_WHITE)
                    }
                    Spacer()
                    // E isso aqui poderia ser um componente também, com StepCounter e RefreshButton
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
                    //MARK: GRID DO JOGO
                    LazyVGrid(columns: levelGrid, spacing: 0){
                        ForEach((0...levelModel[levelNumber].levelMap.count-1), id: \.self) { num in
                            Group{
                                
                                // Os assets deveriam estar na PatchModel
                                // Esse If/Else pode virar uma função na LevelViewModel
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
                                // this only happens when a cauldron is in the marked place
                                // Talvez isso não deveria estar assim (?), talvez deveria ser uma função na LevelViewModel
                                else if levelModel[levelNumber].levelMap[num] == box && levelSpotsIndex.contains(num) {
                                    if !isGameOver{
                                        Image(getPatchAssets(patch: patch, images: [ImageAsset.TILE_CAULDRON, ImageAsset.TILE_BLOSSOMED]))
                                            .resizable()
                                            .scaledToFill()
                                    }else{
                                        getAnimation(patch: patch)
                                    }
                                    
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
                // Ernesto: "isso tem que sumir"
                // Ernesto: "isso não é um onboarding"
                // Renomear para Coachmark
                // O onboarding tem que virar um componente e as informações tem que vir do PatchModel
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
                                Spacer()
                                AnimatingImage(images: images, interval: 0.1)
                                    .frame(height: safeDimensionManager.dimensions.height / 4)
                                    .padding(.leading, safeDimensionManager.dimensions.width * 0.11)
                                    .padding(.bottom, safeDimensionManager.dimensions.height * 0.2)
                                Spacer()
                                
                                ZStack(alignment: .bottom){
                                    Rectangle().frame(width: safeDimensionManager.dimensions.width, height: 230).cornerRadius(40)
                                    HStack{
                                        Text(ContentComponent.ANIMATION_TEXT)
                                            .frame(width: safeDimensionManager.dimensions.width * 0.6)
                                            .foregroundColor(Color(ColorAsset.MAIN_GREEN))
                                            .font(.custom(ContentComponent.BOREL_REGULAR, size: 14))
                                            .padding(.top, 15)
                                            .padding(.horizontal, safeDimensionManager.dimensions.width * 0.1)
                                            .padding(.bottom, 73)
                                        Spacer()
                                    }
                                    HStack{
                                        Spacer()
                                        Image("WITCHIE-ONBOARDING-2")
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                }
                
                //MARK: Changes the screen when the game is over
                // Isso é a tela pós conclusão de nível
                // Essa tela deveria ser um componente
                // Não deveria sobrepor a LevelView inteira, apenas substituir (tira o StepCounter, o RefreshButton e o Grid, e coloca o balão de fala e o botão)
                if showEnding{
                    ZStack{
                        getPatchBackground(patch: patch, backgrounds: [AnyView(DenBackground()), AnyView(GardenBackground())])
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
                                // Isso já é um componente, só trocar
                                Text(levelModel[levelNumber].levelDialogue)
                                    .padding(safeDimensionManager.dimensions.height * 0.04)
                                    .background(
                                        Image(getPatchAssets(patch: patch, images: [ImageAsset.DIALOGUE_RECTANGLE, ImageAsset.AFTER_LEVEL_CHAPTER2]))
                                            .resizable()
                                            .scaledToFill()
                                    )
                                    .frame(width: (safeDimensionManager.dimensions.height * 0.5) / 1.23, height: safeDimensionManager.dimensions.height * 0.5)
                                    .multilineTextAlignment(.center)
                                    .font(.custom(ContentComponent.BOREL_REGULAR, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT * 0.98))
                                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                            }
                            Spacer()
                            // Isso aqui vai pra o LevelViewModel e só chamar aqui
                            // Várias coisas aqui rolam ser componetizadas
                            if (levelNumber < LevelModel.getLevels(chapter: patch).count - 1) {
                                if (levelNumber == 8 && patch == 1){
                                    if UserSettings.hasSeenNewChapter == true {
                                        Button{
                                            refreshGame()
                                            levelNumber += 1
                                            refreshGame()
                                            isGameOver.toggle()
                                            showEnding.toggle()
                                        }
                                    label: {
                                        Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 0.43)
                                    }
                                    }
                                    else {
                                        NavigationLink(destination: PatchSelectorView()) {
                                            Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 0.43)
                                        }       .simultaneousGesture(TapGesture().onEnded({
                                            UserSettings.isNotFirstTime[patch - 1] = true
                                            UserSettings.hasSeenNewChapter = true
                                            defaultsManager.setSeenChapter(value: true)
                                        }))
                                    }
                                }
                                else {
                                    Button{
                                        refreshGame()
                                        levelNumber += 1
                                        refreshGame()
                                        isGameOver.toggle()
                                        showEnding.toggle()
                                    } label: {
                                        Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 0.43)
                                    }
                                }
                            }
                            else {
                                NavigationLink(destination: StartGameView()) {
                                    Image(getPatchAssets(patch: patch, images: [ImageAsset.NEXT_BUTTON_DIALOGUE, ImageAsset.WITCHIE2_DIALOGUE_CHAPTER2]))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.width * 0.43)
                                }
                            }
                        }
                    }
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                }
            } else{
                Text("EITA VIROU LANDSCAPE")
            }
        }
        // Essas coisas de Analytics deveriam virar um AnalyticsManager
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
        // Essa parte aqui vai virar um GameManager
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
                            defineMovement(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset)
                            showOnboarding = false
                        }else if direction == .up{
                            defineMovement(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset * -1)
                        }else if direction == .left{
                            witchImage = getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_LEFT, ImageAsset.WITCHIE_GARDEN_LEFT])
                            defineMovement(actualPosition: levelActualPosition, offset: -1)
                        }else if direction == .right{
                            witchImage = getPatchAssets(patch: patch, images: [ImageAsset.TILE_WITCH_RIGHT, ImageAsset.WITCHIE_GARDEN_RIGHT])
                            if patch == 2 && levelNumber == 0 && showOnboarding{
                                showOnboarding2 = true
                            }
                            defineMovement(actualPosition: levelActualPosition, offset: 1)
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


