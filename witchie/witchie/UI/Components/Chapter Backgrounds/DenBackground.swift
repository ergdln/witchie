//
//  DenBackground.swift
//  witchie
//
//  Created by Guilherme Souza on 15/09/23.
//

import SwiftUI

struct DenBackground: View {
    
    @StateObject var safeDimensionManager = DimensionManager.shared
    
    var body: some View {
        ZStack {
            Image(ImageAsset.BACKGROUND)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: safeDimensionManager.dimensions.width, height: safeDimensionManager.dimensions.height)
        }
        .ignoresSafeArea()
    }
}

struct DenBackground_Previews: PreviewProvider {
    static var previews: some View {
        DenBackground()
    }
}
