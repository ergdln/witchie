//
//  StartGameView.swift
//
//  Created by gms4 on 26/07/23.
//

import SwiftUI
import AVFoundation

struct StartGameView: View {
    
    @State var audioPlayer: AVAudioPlayer!
    @State var animatingI = false
    @State var animatingJ = true
    @StateObject var audioPlayerManager = AudioPlayerManager()
    
    var body: some View{
        
        NavigationView{
            NavigationLink(destination: LevelSelectorView()){
                ZStack{
                    Image(ImageAsset.BACKGROUND)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.8)
                        .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
                    VStack{
                        ZStack{
                            
                            //Draw ALL the 20 dacing elements in the background
                            ForEach((0...10), id: \.self) { num in
                                Group{
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                }
                            }
                           
                            
                            //sabe deus pq vc muda de cor
                            Rectangle()
                                .foregroundColor(.purple)
                                .opacity(0.7)
                                .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
                            ZStack{
                                
                                //lua tem declaração fixa de movimento
                                Image(ImageAsset.MOON)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                                
                                //bruxinha principal tem declaraçao fixa de movimento
                                Image(ImageAsset.WITCH_START)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5)
                                    .offset(x: {
                                        if animatingJ && !animatingI {
                                            return 100
                                        }  else if animatingJ && animatingI {
                                            return -20
                                        } else {
                                            return -95
                                        }
                                    }(),
                                            y: {
                                        if animatingJ && !animatingI {
                                            return UIScreen.main.bounds.height * 0.1
                                        }  else if animatingJ && animatingI {
                                            return UIScreen.main.bounds.height * 0.1
                                        } else {
                                            return UIScreen.main.bounds.height * 0.1
                                        }
                                    }())
                                    .animation(.easeInOut(duration: 3.5).repeatForever(), value: animatingJ)
                                    .onAppear {
                                        animatingJ.toggle()
                                    }
                                    .onChange(of: animatingJ) { _ in
                                        animatingI.toggle()
                                        animatingJ.toggle()
                                    }
                            }.frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                                .navigationBarBackButtonHidden(true)
                                .navigationViewStyle(StackNavigationViewStyle())
                        }
                    }.navigationBarBackButtonHidden(true)
                }
           }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
extension StartGameView {
    
    //MARK: Function that generates images in random positions with random movements
    func drawingDacingElements(image: String) -> some View{
        
        //Image tilt
        let rotationEffect: Float = Float.random(in: -0.2..<0.2)
        //Image horizontal offset
        let xOffSet1: Int = Int.random(in: -2000..<2000)
        let xOffSet2: Int = Int.random(in: -2000..<2000)
        let xOffSet3: Int = Int.random(in: -2000..<2000)
        //Image vertical offset
        let yOffSet1: Int = Int.random(in: -2000..<2000)
        let yOffSet2: Int = Int.random(in: -2000..<2000)
        let yOffSet3: Int = Int.random(in: -2000..<2000)
        //Image speed
        let duration: Int = Int.random(in: 30..<40)
    
        return Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
            .rotationEffect(.radians(Double(rotationEffect)))
            .offset(x: {
                if animatingJ && !animatingI {
                    return CGFloat(xOffSet1)
                }  else if animatingJ && animatingI {
                    return CGFloat(xOffSet2)
                } else {
                    return CGFloat(xOffSet3)
                }
            }(),
                    y: {
                if animatingJ && !animatingI {
                    return CGFloat(yOffSet1)
                }  else if animatingJ && animatingI {
                    return CGFloat(yOffSet2)
                } else {
                    return CGFloat(yOffSet3)
                }
            }())
            .animation(.easeInOut(duration: Double(duration)).repeatForever(), value: animatingJ)
        
        
    }
}
