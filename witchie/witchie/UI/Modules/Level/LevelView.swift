//
//  LevelView.swift
//  witchie
//
//  Created by ditthales on 21/07/23.
//

import SwiftUI
import AVFoundation

struct LevelView: View{
    
    @State private var soundOn = true
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @State var levelNumber: Int
    @State var levelModel: [LevelModel]
    var patch: Int
    
    @State var levelGrid: [GridItem]
    @State var levelSpotsIndex: [Int]
    @State var levelActualPosition: Int
    @State var levelStartPosition: Int
    
    //MARK: VARIABLES
    @State private var isGameOver = false
    @State private var gestureOffset: CGSize = .zero
    @State private var direction: Direction = .none
    @State private var playerMovements: Int = 0
    
    //Onboarding things
    @State var showOnboarding: Bool
    private let images = (1...11).map { String(format: "frame-%d", $0) }.map { Image($0) }
    
    @StateObject var safeDimensionManager = DimensionManager.shared
    
    enum Direction {
        case none, up, down, left, right
    }
    
    //witch first image
    @State var witchImage: String = ImageAsset.TILE_WITCH_LEFT
    
    //Rename de map elements
    let box: String = "📦"
    let grass: String = "⬜️"
    let person: String = "🙋🏿"
    let wall: String = "⬛️"
    let spot: String = "🔯"
    let empty: String = "🟫"
    
    //future map elements
    let crate: String = "🗄️"
    let hole: String = "🕳️"
    
    init(patch: Int, levelNumber: Int, showOnboarding: Bool = false) {
        self.patch = patch
        self._levelNumber = State(initialValue: levelNumber)
        self._levelModel = State(initialValue: LevelModel.getLevels(chapter: patch))
        self._levelGrid = State(initialValue: Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: LevelModel.getLevels(chapter: patch)[levelNumber].levelOffset))
        self._levelSpotsIndex = State(initialValue: LevelModel.getIndexes(of: "🔯", in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap))
        self._levelStartPosition = State(initialValue: LevelModel.getIndexes(of: "🙋🏿", in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)[0])
        self._levelActualPosition = State(initialValue: LevelModel.getIndexes(of: "🙋🏿", in: LevelModel.getLevels(chapter: patch)[levelNumber].levelMap)[0])
        self._showOnboarding = State(initialValue: showOnboarding)
    }
    
    @Environment(\.dismiss) private var dismiss
    
    //MARK: THE GAME VIEW
    var body: some View{
        ZStack{
            if true {//safeDimensionManager.orientation == .portrait{
                Image(ImageAsset.BACKGROUND)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                VStack(alignment: .center, spacing: 10) {
                    HStack(alignment: .center) {
                        if UserSettings.isNotFirstTime{
                            Button{
                                dismiss()
                            }label:{
                                Text("<").foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                    .font(.custom(ContentComponent.regular, size: 24))
                                    .padding(.bottom, -15)
                            }
                        }else{
                            NavigationLink(destination: StartGameView()) {
                                Text("<").foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                    .font(.custom(ContentComponent.regular, size: 24))
                                    .padding(.bottom, -15)
                            }
                            .simultaneousGesture(TapGesture().onEnded({
                                UserSettings.isNotFirstTime = true
                            }))
                        }
                        Spacer()
                        Text("Nível \(levelNumber + 1)")
                            .font(.custom(ContentComponent.regular, size: 32))
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
                                    Image(ImageAsset.TILE_BRICK)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == grass{
                                    Image(ImageAsset.TILE_GRASS)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == hole{
                                    Image(ImageAsset.TILE_HOLE)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == crate{
                                    Image(ImageAsset.TILE_CRATE)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == spot{
                                    Image(ImageAsset.TILE_SPOT)
                                        .resizable()
                                        .scaledToFill()
                                }
                                //this only happens when a cauldron is in the mark place
                                else if levelModel[levelNumber].levelMap[num] == box && levelSpotsIndex.contains(num) {
                                    Image(ImageAsset.TILE_CAULDRON)
                                        .resizable()
                                        .scaledToFill()
                                }
                                else if levelModel[levelNumber].levelMap[num] == box{
                                    Image(ImageAsset.TILE_EMPTY_CAULDRON)
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
                        Color.black
                            .opacity(0.4)
                        AnimatingImage(images: images)
                            .frame(height: safeDimensionManager.dimensions.height / 2)
                            .padding(.leading, safeDimensionManager.dimensions.width * 0.13)
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
                                    Text("<").foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                        .font(.custom(ContentComponent.regular, size: 24))
                                        .padding(.bottom, -15)
                                        .opacity(0)
                                }.disabled(true)
                                Spacer()
                                Text("Nível \(levelNumber + 1)")
                                    .font(.custom(ContentComponent.regular, size: 32))
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
                                    .font(.custom(ContentComponent.regular, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT * 0.98))
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
                            defineMoviment(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset)
                            showOnboarding = false
                        }else if direction == .up{
                            defineMoviment(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset * -1)
                        }else if direction == .left{
                            witchImage = ImageAsset.TILE_WITCH_LEFT
                            defineMoviment(actualPosition: levelActualPosition, offset: -1)
                        }else if direction == .right{
                            witchImage = ImageAsset.TILE_WITCH_RIGHT
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
//MARK: Game Functions
extension LevelView{
    
    private func getDirection(from translation: CGSize) -> Direction {
        let x = translation.width
        let y = translation.height
        
        if x > 25 && abs(y) < x {
            return .right
        } else if x < -25 && abs(y) < abs(x) {
            return .left
        } else if y > 25 && abs(x) < y {
            return .down
        } else if y < -25 && abs(x) < abs(y) {
            return .up
        }
        
        return .none
    }
    
    func refreshGame(){
        print(safeDimensionManager.dimensions)
        playerMovements = 0
        levelModel[levelNumber].levelMap = LevelModel.getLevels(chapter: 1)[levelNumber].levelMap
        levelActualPosition = levelStartPosition
        levelGrid = Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: levelModel[levelNumber].levelOffset)
        levelSpotsIndex = LevelModel.getIndexes(of: "🔯", in: levelModel[levelNumber].levelMap)
        levelStartPosition = LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0]
        levelActualPosition = LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0]
    }
    
    func defineMoviment(actualPosition: Int, offset: Int){
        //FACED A HOLE
        if levelModel[levelNumber].levelMap[actualPosition + offset] == hole {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                refreshGame()
            }
        }
        //WALKING IN FREE SPACE
        else if levelModel[levelNumber].levelMap[actualPosition + offset] == grass {
            levelModel[levelNumber].levelMap.swapAt(actualPosition + offset, actualPosition)
            levelActualPosition = actualPosition + offset
            //recursion stop condition
            if (levelModel[levelNumber].levelMap[levelActualPosition + offset] == box) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == wall) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == spot) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == crate) {
                //here, nothing happens
                //you hit something, so it's just time to stop walking
                //then finally it's it time to count the movement:
                playerMovements += 1
                
            }//recursion is called when the next block is TILE_FLOOR
            else{
                defineMoviment(actualPosition: levelActualPosition, offset: offset)
                //keep walking
            }
        }
        //PUSHING CRATE
               else if levelModel[levelNumber].levelMap[levelActualPosition + offset] == crate && levelModel[levelNumber].levelMap[actualPosition + offset + offset] == grass{
                   
                   levelModel[levelNumber].levelMap[actualPosition] = grass
                   levelModel[levelNumber].levelMap[actualPosition + offset] = person
                   levelModel[levelNumber].levelMap[actualPosition + offset + offset] = crate
                   levelActualPosition = actualPosition + offset
                   //if you successfully pushed a box, update playerMovements
                   playerMovements += 1
               }
        //PUSHING A CAULDRON
        else if levelModel[levelNumber].levelMap[levelActualPosition + offset] == box && !levelSpotsIndex.contains(levelActualPosition + offset) {
            //pushing a box into a mark (sound effects)
            // Gui olha aqui dps
            if levelModel[levelNumber].levelMap[actualPosition + offset + offset] == spot {
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
                //if you successfully pushed a box, update playerMovements
                playerMovements += 1
            }
            //pushing a cauldron in free space (same code, but no sounds effects)
            else if levelModel[levelNumber].levelMap[actualPosition + offset + offset] != wall && levelModel[levelNumber].levelMap[actualPosition + offset + offset] != box{
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
                //if you successfully pushed a box, update playerMovements
                playerMovements += 1
            }
        }
        if isLevelCompleted(platesPosition: levelSpotsIndex){
            self.isGameOver.toggle()
            LevelCompleted.isCompleted[patch]![levelNumber] = true
            UserDefaults.standard.set(LevelCompleted.isCompleted[patch], forKey: patch == 1 ? "CurrentLevel" : "CurrentLevel\(patch)")
            UserDefaults.standard.set(true, forKey: "isNotFirstTime")
            if playerMovements < UserSettings.records[patch]![levelNumber] || UserSettings.records[patch]![levelNumber] == 0 {
                UserSettings.records[patch]![levelNumber] = playerMovements
                UserDefaults.standard.set(UserSettings.records[patch], forKey: "records\(patch)")
            }
        }
    }
    
    //    func playCauldronSoundEffects(){
    //        var audioPlayer: AVAudioPlayer
    //        let url = Bundle.main.url(forResource: "CauldronAlert", withExtension: "mp3")
    //        guard url != nil else {
    //            return
    //        }
    //        do {
    //            audioPlayer = try AVAudioPlayer(contentsOf: url!)
    //            audioPlayer?.play()
    //        } catch {
    //
    //        }
    //    }
    
    //MARK: function that checks if the level is completed
    func isLevelCompleted(platesPosition: [Int]) -> Bool{
        if (platesPosition.allSatisfy{levelModel[levelNumber].levelMap[$0] == box}){
            
            return true
        }
        else{
            return false
        }
    }
}


struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


