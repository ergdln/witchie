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
                            //gerar esse bagulho com loops dps
                            Group{
                                Group{
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                }
                                Group{
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                    drawingDacingElements(image: ImageAsset.CAULDRON_CLEAN)
                                }
                                Group{
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                }
                                Group{
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                    drawingDacingElements(image: ImageAsset.SPOT_CLEAN)
                                }
                            }
                            
                            //sabe deus pq vc muda de cor
                            Rectangle()
                                .opacity(0.7)
                                .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
                            
                            //lua tem declaração fixa de movimento
                            Image(ImageAsset.MOON)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 600, height: 600)
                            
                            //bruxinha principal tem declaraçao fixa de movimento
                            Image(ImageAsset.WITCH_START)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 400, height: 400)
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
                                        return 100
                                    }  else if animatingJ && animatingI {
                                        return 100
                                    } else {
                                        return 100
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
        let duration: Int = Int.random(in: 1..<10)
    
        return Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
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
