//
//  GardenBackground.swift
//  witchie
//
//  Created by Guilherme Souza on 14/09/23.
//

import SwiftUI

struct GardenBackground: View {
    
    @StateObject var safeDimensionManager = DimensionManager.shared
    let endPoint = UnitPoint(x: 0.5, y: 0.3)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color(ColorAsset.GRADIENT1).opacity(0.95), Color(ColorAsset.GRADIENT2)]), startPoint: .top, endPoint: endPoint)
                )
            VStack {
                Spacer()
                Image(ImageAsset.BUSH_BACKGROUND)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.2)
            }
        }
        .ignoresSafeArea()
    }
}

struct GardenBackground_Previews: PreviewProvider {
    static var previews: some View {
        GardenBackground()
    }
}
