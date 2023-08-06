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
    
    @State var levelGrid: [GridItem]
    @State var levelSpotsIndex: [Int]
    @State var levelActualPosition: Int
    @State var levelStartPosition: Int
    
    //MARK: VARIABLES
    @State private var isGameOver = false
    @State private var gestureOffset: CGSize = .zero
    @State private var direction: Direction = .none
    @State private var playerMovements: Int = 0

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
    
    init(levelNumber: Int, levelModel: [LevelModel]) {
        self._levelNumber = State(initialValue: levelNumber)
        self._levelModel = State(initialValue: levelModel)
        self._levelGrid = State(initialValue: Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: levelModel[levelNumber].levelOffset))
        self._levelSpotsIndex = State(initialValue: LevelModel.getIndexes(of: "🔯", in: levelModel[levelNumber].levelMap))
        self._levelStartPosition = State(initialValue: LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0])
        self._levelActualPosition = State(initialValue: LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0])
    }
    
    @Environment(\.dismiss) private var dismiss
    
    //MARK: THE GAME VIEW
    var body: some View{
        ZStack{
            Image(ImageAsset.BACKGROUND)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 1.1)
            
            VStack(alignment: .center, spacing: 10){
                HStack(alignment: .center){
                    Button{
                        dismiss()
                        
                    }label: {
                        Text("<").foregroundColor(Color(ColorAsset.WHITE))
                            .font(.custom(ContentComponent.regular, size: 24))
                                .padding(.bottom, -15)
                    }
                    Spacer()
                    Text("Nível \(levelNumber + 1)")
                        .font(.custom(ContentComponent.regular, size: 32))
                            .foregroundColor(Color(ColorAsset.WHITE))
                            .padding(.bottom, -20)
                    Spacer()
                    SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.WHITE)
                }
                Spacer()
                ZStack{
                    HStack {
                        ZStack {
                            Image(ImageAsset.COUNTER)
                            Text(String(playerMovements))
                                .foregroundColor(Color(ColorAsset.WHITE))
                                    .font(.custom(ContentComponent.regular, size: 24))
                                        .padding(.bottom, -15)
                                        .padding(.leading, 41)
                        }
                        Button(action:{
                            refreshGame()
                        }){
                            Image(ImageAsset.REFRESH_BUTTON)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 38)
                        }.frame(width: 200, alignment: .trailing)
                            .disabled(isGameOver)
                    }
                }
                
                //MARK: GAME GRID
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
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8)
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: Changes the screen when the game is over
            if isGameOver{
                ZStack{
                    if levelNumber != LevelModel.patchOne().count - 1{
                        Image(ImageAsset.BACKGROUND)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
                        VStack{
                            Text(levelModel[levelNumber].levelDialogue)
                            Button{
                                refreshGame()
                                levelNumber += 1
                                refreshGame()
                                isGameOver.toggle()
                            }label: {
                                Image(ImageAsset.OK_BUTTON)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 50)
                            }
                        }.frame(width:500, alignment: .trailing)
                    }else{
                        Text("TAPORRA ZERASSE BOY")
                        Button{
                            refreshGame()
                            isGameOver.toggle()
                            dismiss()
                        }label: {
                            Image(ImageAsset.OK_BUTTON)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                        }
                    }
                }.foregroundColor(.white)
            }
        }
        
        //MARK: New sliding game controls
        .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.gestureOffset = gesture.translation
                        self.direction = self.getDirection(from: gesture.translation)
                    }
                    .onEnded { gesture in
                        if direction == .down{
                            defineMoviment(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset)
                        }else if direction == .up{
                            defineMoviment(actualPosition: levelActualPosition, offset: levelModel[levelNumber].levelOffset * -1)
                        }else if direction == .left{
                            witchImage = ImageAsset.TILE_WITCH_LEFT
                            defineMoviment(actualPosition: levelActualPosition, offset: -1)
                        }else if direction == .right{
                            witchImage = ImageAsset.TILE_WITCH_RIGHT
                            defineMoviment(actualPosition: levelActualPosition, offset: 1)
                        }else{
                            print("none")
                        }
                        self.gestureOffset = .zero
                        self.direction = .none
                        
                    }
            )
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
        playerMovements = 0
        levelModel[levelNumber].levelMap = LevelModel.patchOne()[levelNumber].levelMap
        levelActualPosition = levelStartPosition
        levelGrid = Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: levelModel[levelNumber].levelOffset)
        levelSpotsIndex = LevelModel.getIndexes(of: "🔯", in: levelModel[levelNumber].levelMap)
        levelStartPosition = LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0]
        levelActualPosition = LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0]
    }
    
    func defineMoviment(actualPosition: Int, offset: Int){
        //WALKING IN FREE SPACE
        if levelModel[levelNumber].levelMap[actualPosition + offset] == grass {
            levelModel[levelNumber].levelMap.swapAt(actualPosition + offset, actualPosition)
            levelActualPosition = actualPosition + offset
            //recursion stop condition
            if (levelModel[levelNumber].levelMap[levelActualPosition + offset] == box) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == wall) {
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
        //PUSHING A CAULDRON
        else if levelModel[levelNumber].levelMap[levelActualPosition + offset] == box && !levelSpotsIndex.contains(levelActualPosition + offset) {
            //pushing a box into a mark (sound effects)
            if levelModel[levelNumber].levelMap[actualPosition + offset + offset] == spot{
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
            }
            //pushing a cauldron in free space (same code, but no sounds effects)
            else if levelModel[levelNumber].levelMap[actualPosition + offset + offset] != wall && levelModel[levelNumber].levelMap[actualPosition + offset + offset] != box{
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
            }
            //if you successfully pushed a box, update playerMovements
            playerMovements += 1
        }
        if isLevelCompleted(platesPosition: levelSpotsIndex){
            self.isGameOver.toggle()
            LevelCompleted.isCompleted[levelNumber] = true
            UserDefaults.standard.set(LevelCompleted.isCompleted, forKey: "CurrentLevel")
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
        LevelView(levelNumber: 0, levelModel: LevelModel.patchOne()).environmentObject(AudioPlayerManager())
    }
}
