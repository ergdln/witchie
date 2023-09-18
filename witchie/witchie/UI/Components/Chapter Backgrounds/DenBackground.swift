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
            Image(ImageAsset.BACKGROUND)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
    }
}

struct DenBackground_Previews: PreviewProvider {
    static var previews: some View {
        DenBackground()
    }
}
