//
//  SwiftUIView.swift
//  witchie
//
//  Created by egln on 14/09/23.
//

import SwiftUI

struct ChapterTransitionTextBox: View {
    @StateObject var safeDimensionManager = DimensionManager.shared
    var TransitionText: String
    var body: some View {
        Group{
            Text(TransitionText)
                .padding(safeDimensionManager.dimensions.height * 0.04)
                .background(
                    Image(ImageAsset.DIALOGUE_123)
                        .resizable()
                        .scaledToFill())
               .frame(width: (safeDimensionManager.dimensions.height * 0.38)/0.94, height: safeDimensionManager.dimensions.height * 0.38)
                .multilineTextAlignment(.center)
                .font(.custom(ContentComponent.BOREL_REGULAR, size: safeDimensionManager.dimensions.height * ContentComponent.CARD_FONT))
                .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
        }
        .padding(.top, safeDimensionManager.dimensions.height * 0.15)
    }
}

struct TransitionTextBoxView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterTransitionTextBox(TransitionText: "eae")
    }
}
