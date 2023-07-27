//
//  LevelView.swift
//  witchie
//
//  Created by ditthales on 21/07/23.
//

import SwiftUI

struct LevelView: View{
    
    
    
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

    enum Direction {
        case none, up, down, left, right
    }
    
    //witch first image
    @State var witchImage: String = "WITCH-LEFT"
    
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
            Image("BACKGROUND")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
            
            VStack(alignment: .center, spacing: 10){
                ZStack{
                    HStack {
                        Button(action:{
                            dismiss()
                        }){
                            Text("Back to menu")
                                .foregroundColor(.white)
                                .padding()
                                .border(.white)
                        }.frame(alignment: .trailing)
                            .disabled(isGameOver)
                        Button(action:{
                            refreshGame()
                        }){
                           Image("REFRESH")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 50)
                        }.frame(width: 200, alignment: .trailing)
                            .disabled(isGameOver)
                    }
                }
                Spacer()
                
                //MARK: GAME GRID
                LazyVGrid(columns: levelGrid, spacing: 0){
                    ForEach((0...levelModel[levelNumber].levelMap.count-1), id: \.self) { num in
                        if levelModel[levelNumber].levelMap[num] == wall{
                            Image("Brick")
                                .resizable()
                                .scaledToFill()
                        }
                        else if levelModel[levelNumber].levelMap[num] == grass{
                            Image("GRASS")
                                .resizable()
                                .scaledToFill()
                        }
                        else if levelModel[levelNumber].levelMap[num] == spot{
                            Image("SPOT")
                                .resizable()
                                .scaledToFill()
                        }
                        else if levelModel[levelNumber].levelMap[num] == box{
                            Image("CAULDRON")
                                .resizable()
                                .scaledToFill()
                        }
                        else if levelModel[levelNumber].levelMap[num] == person{
                            Image(witchImage)
                                .resizable()
                                .scaledToFill()
                        }
                        else if levelModel[levelNumber].levelMap[num] == empty{
                            Image("empty")
                                .resizable()
                                .scaledToFill()
                        }
                    }
                }
                
            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: Changes the screen when the game is over
            if isGameOver{
                ZStack{
                    if levelNumber != LevelModel.patchOne().count - 1{
                        Image("BACKGROUND")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
                        
                        VStack{
//                            Image("L2COMPLETED")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 700, height: 700)
                            Text("terminasse o nivel \(levelNumber + 1), mas foi facil")
                            Text("vamo ver se no nivel \(levelNumber + 2) tu eh pica msm")
                            Button{
                                refreshGame()
                                levelNumber += 1
                                refreshGame()
                                isGameOver.toggle()
                            }label: {
                                Image("OK")
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
                            Image("OK")
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
                            witchImage = "WITCH-LEFT"
                            defineMoviment(actualPosition: levelActualPosition, offset: -1)
                        }else if direction == .right{
                            witchImage = "WITCH-RIGHT"
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
        levelModel[levelNumber].levelMap = LevelModel.patchOne()[levelNumber].levelMap
        levelActualPosition = levelStartPosition
        levelGrid = Array(repeating: GridItem(.flexible(minimum: 30, maximum: 150), spacing: 0), count: levelModel[levelNumber].levelOffset)
        levelSpotsIndex = LevelModel.getIndexes(of: "🔯", in: levelModel[levelNumber].levelMap)
        levelStartPosition = LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0]
        levelActualPosition = LevelModel.getIndexes(of: "🙋🏿", in: levelModel[levelNumber].levelMap)[0]
    }
    //MARK: Game Functions
    func defineMoviment(actualPosition: Int, offset: Int){
        //walking in free space recursively
        if levelModel[levelNumber].levelMap[actualPosition + offset] == grass {
            levelModel[levelNumber].levelMap.swapAt(actualPosition + offset, actualPosition)
            levelActualPosition = actualPosition + offset
            //recursion
            if (levelModel[levelNumber].levelMap[levelActualPosition + offset] == box) || (levelModel[levelNumber].levelMap[levelActualPosition + offset] == wall) {
                //while walking you hit something, so it's time to stop walking
            }
            else{
                //keep moving
                defineMoviment(actualPosition: levelActualPosition, offset: offset)
            }
        }
        //pushing a box
        else if levelModel[levelNumber].levelMap[levelActualPosition + offset] == box && !levelSpotsIndex.contains(levelActualPosition + offset) {
            if levelModel[levelNumber].levelMap[actualPosition + offset + offset] != wall && levelModel[levelNumber].levelMap[actualPosition + offset + offset] != box{
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelActualPosition = actualPosition + offset
            }
        }
        else{
            //moving agains a wall or plate
            //stop walking
        }
        //checking if the level is done
        if isLevelCompleted(platesPosition: levelSpotsIndex){
            self.isGameOver.toggle()
            LevelCompleted.isCompleted[levelNumber] = true
        }
    }
    
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
        LevelView(levelNumber: 0, levelModel: LevelModel.patchOne())
    }
}
