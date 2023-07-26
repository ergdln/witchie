//
//  LevelSelectorView.swift
//  witchie
//
//  Created by ditthales on 25/07/23.
//

import SwiftUI

struct LevelSelectorView: View {
    
    @State var isCompleted: [Bool] = LevelCompleted.isCompleted
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50){
                ForEach(Array(0..<LevelModel.patchOne().count), id: \.self){ level in
                    NavigationLink(destination: LevelView(levelNumber: level, levelModel: LevelModel.patchOne())) {
                        HStack{
                            Text("Level \(level + 1)").font(.largeTitle)
                            if isCompleted[level]{
                                Text("✅")
                            }
                            
                        }
                    }.disabled(shouldDisable(level: level))
                }
            }
            .onAppear{
                isCompleted = LevelCompleted.isCompleted
            }
        }.navigationBarBackButtonHidden()
    }
    
    func shouldDisable(level: Int) -> Bool{
        if level == 0{
            return false
        }else if level == LevelModel.patchOne().count - 1{
            if isCompleted[level - 1]{
                return false
            }
            return true
        }else{
            return !isCompleted[level - 1]
        }
    }
}


struct LevelSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectorView()
    }
}
