//
//  TesteView.swift
//  witchie
//
//  Created by ditthales on 11/08/23.
//

import SwiftUI

struct TesteView: View {
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
    
    var safeDimensionManager = DimensionManager.shared
    
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
    var body: some View {
        ZStack{
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
                    ZStack {
                        Image(ImageAsset.COUNTER)
                        Text(String(playerMovements))
                            .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            .font(.custom(ContentComponent.regular, size: 24))
                            .padding(.bottom, -15)
                            .padding(.leading, 41)
                    }
                    Spacer()
                    Button(action:{
                        //refreshGame()
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
        }
    }
}

struct TesteView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
