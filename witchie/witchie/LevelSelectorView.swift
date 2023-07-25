//
//  LevelSelectorView.swift
//  witchie
//
//  Created by ditthales on 25/07/23.
//

import SwiftUI

struct LevelSelectorView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 50){
                ForEach(Array(0..<LevelModel.fases().count), id: \.self){ level in
                    NavigationLink(destination: LevelView(levelNumber: level, levelModel: LevelModel.fases())) {
                        Text("Level \(level + 1)").font(.largeTitle)
                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
}


struct LevelSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectorView()
    }
}
