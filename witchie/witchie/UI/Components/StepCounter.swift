//
//  StepCounter.swift
//  witchie
//
//  Created by jpbol on 17/08/2023.
//

import Foundation
import SwiftUI

struct StepCounter: View {
    let imageName: String
    let playerMovements: Int
    let type: StepCounterType
    @StateObject var dimensionManager = DimensionManager.shared
    
    var body: some View {
        switch type {
        case .levelView:
            ZStack {
                Image(imageName)
                Text(String(playerMovements))
                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                    .font(.custom(ContentComponent.regular, size: 24))
                    .padding(.bottom, -15)
                    .padding(.leading, 41)
            }
        case .levelSelectorView:
            ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                Text(String(playerMovements))
                    .foregroundColor(Color(ColorAsset.MAIN_PURPLE))
                    .font(.custom(ContentComponent.regular, size: dimensionManager.dimensions.height * ContentComponent.STEP_COUNTER_FONT))
                    .padding(.bottom, -10)
                    .padding(.leading, 41)
            }
        }

    }
}
