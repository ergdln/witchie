//
//  StartGameView.swift
//
//  Created by gms4 on 26/07/23.
//

import SwiftUI
import AVFoundation

struct StartGameView: View {
    
    //background cauldrons booleans for movement
    @State var animatingI = false
    @State var animatingJ = true
    
    //witchie booleans for movement
    @State var animatingK = false
    @State var animatingW = true
    
    @State private var soundOn = true
    @State var audioPlayer: AVAudioPlayer!
    @EnvironmentObject private var audioPlayerManager: AudioPlayerManager
    @State private var path = NavigationPath()
    
    @StateObject var safeDimensionManager = DimensionManager.shared
    
    var body: some View {
        
        NavigationStack(path: $path) {
            ZStack {
                //the background
                Rectangle()
                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                    .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                //dacing elements
                VStack {
                    ZStack {
                        
                        //draws all the 20 dacing elements in the background
                        ForEach((0...25), id: \.self) { num in
                            Group {
                                drawingDacingElements(image: ImageAsset.CAULDRON_FULL)
                            }
                        }
                        //purple filter
                        Rectangle()
                            .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                            .opacity(0.95)
                            .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
                        
                        VStack(spacing: 10) {
                            HStack (alignment: .center) {
                                Spacer()
                                SoundToggleComponent(soundOn: $soundOn, audioPlayerManager: audioPlayerManager, color: ColorAsset.MAIN_WHITE)
                            }
                            .padding(.horizontal, 32.0)
                            .padding(.top, safeDimensionManager.dimensions.height * 0.05)
                            .frame(width: safeDimensionManager.dimensions.width)
                            //                                .border(.green)
                            
                            //Spacer()
                            
                            //logo witchie
                            Image(ImageAsset.WITCH_LOGO_CURVED)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: safeDimensionManager.dimensions.width * 0.7, height: safeDimensionManager.dimensions.width * 0.3)
                                .offset(x: {
                                    if animatingW && !animatingK {
                                        return 0
                                    }  else if animatingW && animatingK {
                                        return 0
                                    } else {
                                        return 0
                                    }
                                }(),
                                        y: {
                                    if animatingW && !animatingK {
                                        return safeDimensionManager.dimensions.width * 0.13
                                    }  else if animatingW && animatingK {
                                        return 0
                                    } else {
                                        return safeDimensionManager.dimensions.width * 0.1
                                        
                                    }
                                }())
                                .animation(.easeInOut(duration: 3).repeatForever(), value: animatingW)
                            
                            //moon and witchie assets dacing
                            ZStack {
                                //dacing moon
                                Image(ImageAsset.MOON)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: safeDimensionManager.dimensions.width * 0.7, height: safeDimensionManager.dimensions.height * 0.7)
                                
                                //dacing wichie
                                Image(ImageAsset.WITCH_START)
                                    .resizable()
                                    .rotationEffect(.radians(Double(0.15)))
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: safeDimensionManager.dimensions.width * 0.5, height: safeDimensionManager.dimensions.width * 0.5)
                                    .offset(x: {
                                        if animatingW && !animatingK {
                                            return 100
                                        }  else if animatingW && animatingK {
                                            return -20
                                        } else {
                                            return -95
                                        }
                                    }(),
                                            y: {
                                        if animatingW && !animatingK {
                                            return safeDimensionManager.dimensions.width * 0.15
                                        }  else if animatingW && animatingK {
                                            return safeDimensionManager.dimensions.width * 0.15
                                        } else {
                                            return safeDimensionManager.dimensions.width * 0.15
                                        }
                                    }())
                                    .animation(.easeInOut(duration: 3.5).repeatForever(), value: animatingW)
                                    .onAppear {
                                        animatingW.toggle()
                                        animatingJ.toggle()
                                    }
                                    .onChange(of: animatingW) { _ in
                                        animatingK.toggle()
                                        // LEGACY
                                        // quer emoção? descomente a linha abaixo
                                        // animatingW.toggle()
                                    }
                                    .onChange(of: animatingJ) { _ in
                                        animatingI.toggle()
                                    }
                                
                            }.frame(width: safeDimensionManager.dimensions.width * 0.8, height: safeDimensionManager.dimensions.width * 0.8)
                                .navigationBarBackButtonHidden(true)
                            
                            Spacer()
                                .frame(height: safeDimensionManager.dimensions.height * 0.02)
                            
                            NavigationLink {
                                if UserSettings.isNotFirstTime {
                                    PatchSelectorView()
                                } else {
                                    Patch1TransitionView()
                                }
                            } label: {
                                ZStack {
                                    Image(ImageAsset.BEGIN_BUTTON_BACKGROUND)
                                    Text(ContentComponent.BEGIN)
                                        .font(.custom(ContentComponent.BOREL_REGULAR, size: 28))
                                        .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                                        .padding(.top, 6)
                                }
                            }
                            Spacer()
                                .frame(height: safeDimensionManager.dimensions.height * 0.001)
                            
                            NavigationLink {
                                AboutUsView()
                            } label: {
                                Text(ContentComponent.ABOUT_US)
                                    .font(.custom(ContentComponent.BOREL_REGULAR, size: 24))
                                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                            }
                            Spacer()
                        }
                        .padding(.bottom, 32.0)
                        .frame(height: safeDimensionManager.dimensions.height * 0.9)
                    }
                }.navigationBarBackButtonHidden(true)
            }
            .ignoresSafeArea()
        }
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
            .frame(width: safeDimensionManager.dimensions.width * 0.3, height: safeDimensionManager.dimensions.width * 0.3)
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
            .animation(.easeInOut(duration: 3.5).repeatForever(), value: animatingJ)
        
        
    }
}

struct StartGameView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
