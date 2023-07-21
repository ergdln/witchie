//
//  ContentView.swift
//  witchie
//
//  Created by egln on 20/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LevelView(levelNumber: 0, levelModel: LevelModel.fases())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
