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
    //MARK: VARIABLES
    @State private var isGameOver = false
    
    //witch first image
    @State var witchImage: String = "WITCH-LEFT"
    
    //Rename de map elements
    let box: String = "📦"
    let grass: String = "⬜️"
    let person: String = "🙋🏿"
    let wall: String = "⬛️"
    let spot: String = "🟨"
    let empty: String = "🟫"
    
    init(levelNumber: Int, levelModel: [LevelModel]) {
        self.levelNumber = levelNumber
        self.levelModel = levelModel
    }
    
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
                            if levelNumber > 0{
                                refreshGame()
                                levelNumber -= 1
                                refreshGame()
                            }
                        }){
                            Text("Previous")
                                .foregroundColor(.white)
                                .padding()
                                .border(.white)
                        }.frame(width: 100, alignment: .trailing)
                            .disabled(isGameOver)
                        Button(action:{
                            if levelNumber < LevelModel.fases().count - 1{
                                refreshGame()
                                levelNumber += 1
                                refreshGame()
                            }
                        }){
                            Text("Next")
                                .foregroundColor(.white)
                                .padding()
                                .border(.white)
                        }.frame(width: 100, alignment: .trailing)
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
                LazyVGrid(columns: levelModel[levelNumber].levelGrid, spacing: 0){
                    ForEach((0...levelModel[levelNumber].levelMap.count-1), id: \.self) { num in
                        if levelModel[levelNumber].levelMap[num] == wall{
                            Image("BRICK")
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
                
                //MARK: game controls
                HStack{
                    Button(action:{
                        witchImage = "WITCH-LEFT"
                        defineMoviment(actualPosition: levelModel[levelNumber].levelStartPosition, offset: -1)
                    }){
                        Image("LEFT")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }.disabled(isGameOver)

                    VStack{
                        Button(action:{
                            defineMoviment(actualPosition: levelModel[levelNumber].levelStartPosition, offset: levelModel[levelNumber].levelOffset * -1)
                        }){
                            Image("UP")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                            
                        }.disabled(isGameOver)
                        Button(action:{
                            defineMoviment(actualPosition: levelModel[levelNumber].levelStartPosition, offset: levelModel[levelNumber].levelOffset)
                        }){
                            Image("DOWN")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                        }
                    }.disabled(isGameOver)
                    Button(action:{
                        witchImage = "WITCH-RIGHT"
                        defineMoviment(actualPosition: levelModel[levelNumber].levelStartPosition, offset: 1)
                    }){
                        Image("RIGHT")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                    }.disabled(isGameOver)
                }.frame(width: 500)
            }.frame(width: 600, height: 600)
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
            
            //MARK: Changes the screen when the game is over
            if isGameOver{
                ZStack{
                    Image("BACKGROUND")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
                    
                    VStack{
                        Image("L2COMPLETED")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 700, height: 700)
                        
                        Button{
                            if levelNumber < LevelModel.fases().count - 1{
                                levelNumber += 1
                                isGameOver.toggle()
                            }
                        }label: {
                            Image("OK")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 50)
                        }
                    }.frame(width:500, alignment: .trailing)
                }
            }
        }
    }
}

extension LevelView{
    
    func refreshGame(){
        levelModel[levelNumber].levelMap = LevelModel.fases()[levelNumber].levelMap
        levelModel[levelNumber].levelStartPosition = LevelModel.fases()[levelNumber].levelStartPosition
    }
    //MARK: Game Functions
    func defineMoviment(actualPosition: Int, offset: Int){
        //walking in free space recursively
        if levelModel[levelNumber].levelMap[actualPosition + offset] == grass {
            levelModel[levelNumber].levelMap.swapAt(actualPosition + offset, actualPosition)
            levelModel[levelNumber].levelStartPosition = actualPosition + offset
            //recursion
            if (levelModel[levelNumber].levelMap[levelModel[levelNumber].levelStartPosition + offset] == box) || (levelModel[levelNumber].levelMap[levelModel[levelNumber].levelStartPosition + offset] == wall) {
                //while walking you hit something, so it's time to stop walking
            }
            else{
                //keep moving
                defineMoviment(actualPosition: levelModel[levelNumber].levelStartPosition, offset: offset)
            }
        }
        //pushing a box
        else if levelModel[levelNumber].levelMap[levelModel[levelNumber].levelStartPosition + offset] == box {
            if levelModel[levelNumber].levelMap[actualPosition + offset + offset] != wall && levelModel[levelNumber].levelMap[actualPosition + offset + offset] != box{
                levelModel[levelNumber].levelMap[actualPosition] = grass
                levelModel[levelNumber].levelMap[actualPosition + offset] = person
                levelModel[levelNumber].levelMap[actualPosition + offset + offset] = box
                levelModel[levelNumber].levelStartPosition = actualPosition + offset
            }
        }
        else{
            //moving agains a wall or plate
            //stop walking
        }
        //checking if the level is done
        if isLevelCompleted(platesPosition: levelModel[levelNumber].levelSpotsIndex){
            self.isGameOver.toggle()
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
        LevelView(levelNumber: 0, levelModel: LevelModel.fases())
    }
}
