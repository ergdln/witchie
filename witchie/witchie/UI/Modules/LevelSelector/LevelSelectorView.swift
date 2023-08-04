//
//  LevelSelectorView.swift
//  witchie
//
//  Created by ditthales on 25/07/23.
//

import SwiftUI
import AVFAudio

struct LevelSelectorView: View {
    @State private var soundOn = true
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @State var isCompleted: [Bool] = LevelCompleted.isCompleted
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 212/255, blue: 207/255)
                .ignoresSafeArea()
            VStack (spacing: 0) {
                HStack (alignment: .center) {
                    Button{
                        dismiss()
                    }label: {
                        Text("<- Voltar").font(.custom(ContentComponent.regular, size: 20))
                    }
                    Spacer()
                    SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager)
                }
                .padding(.horizontal)
                ScrollView {
                    Text("Níveis").font(.custom(ContentComponent.regular, size: 40))
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30, maximum: 300), spacing: 0), count: 3), spacing: 5) {
                        ForEach(Array(0..<LevelModel.patchOne().count), id: \.self) { level in
                            NavigationLink(destination: LevelView(levelNumber: level, levelModel: LevelModel.patchOne())) {
                                VStack(alignment: .center, spacing: 0){
                                    Text("\(level + 1)").font(.custom(ContentComponent.regular, size: 35))
                                        .padding(.bottom, -20)
                                    if isCompleted[level]{
                                        Image("CALDEIRAO")
                                            .resizable()
                                            .scaledToFit()
                                            .scaleEffect(0.8)
                                    }else{
                                        if level != 0{
                                            if isCompleted[level - 1]{
                                                Image("CALDEIRAOVAZIO")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .scaleEffect(0.8)
                                            }else{
                                                Image("CALDEIRAO")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .scaleEffect(0.8)
                                                    .opacity(0.2)
                                            }
                                        }else{
                                            Image("CALDEIRAOVAZIO")
                                                .resizable()
                                                .scaledToFit()
                                                .scaleEffect(0.8)
                                        }
                                        
                                    }
                                }
                            }.disabled(shouldDisable(level: level))
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .padding(.vertical, -60)
                    .onAppear{
                        isCompleted = LevelCompleted.isCompleted
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
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
            .environmentObject(AudioPlayerManager())
    }
}
