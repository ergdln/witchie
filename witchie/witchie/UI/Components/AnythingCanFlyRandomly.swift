//
//  SwiftUIView.swift
//  witchie
//
//  Created by egln on 14/09/23.
//

//
//
//
//
//
//
// THIS COMPONENT IS NOT WORKING YET
// 
//
//
//
//
//
//

import SwiftUI

struct AnythingCanFlyRandomly: View {
    @StateObject var safeDimensionManager = DimensionManager.shared
    //booleans for movement
    @State var animatingM = false
    @State var animatingN = true
    var body: some View {
        ZStack{
            ForEach((0...1000), id: \.self) { num in
                    drawingDacingElements(image: ImageAsset.CAULDRON_FULL)
            }
        }.frame(width: safeDimensionManager.dimensions.width , height: safeDimensionManager.dimensions.width)
    }
    
    //MARK: Function that generates images in random positions with random movements
    func drawingDacingElements(image: String) -> some View{

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
            .offset(x: {
                if animatingN && !animatingM {
                    return CGFloat(xOffSet1)
                }  else if animatingN && animatingM {
                    return CGFloat(xOffSet2)
                } else {
                    return CGFloat(xOffSet3)
                }
            }(),
                    y: {
                if animatingN && !animatingM {
                    return CGFloat(yOffSet1)
                }  else if animatingN && animatingM {
                    return CGFloat(yOffSet2)
                } else {
                    return CGFloat(yOffSet3)
                }
            }())
            .animation(.easeInOut(duration: Double(duration)).repeatForever(), value: animatingN)
            .animation(.easeInOut(duration: 3.5).repeatForever(), value: animatingN)
    }
}

struct AnythingCanFlyRandomlyView_Previews: PreviewProvider {
    static var previews: some View {
        AnythingCanFlyRandomly()
    }
}
