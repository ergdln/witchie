//
//  StepCounter.swift
//  witchie
//
//  Created by jpbol on 17/08/2023.
//

import Foundation
import SwiftUI

struct StepCounter {
    var imageName: String
    var playerMovements: Int
    
    var body: some View {
        ZStack {
            Image(imageName)
            Text(String(playerMovements))
                .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                .font(.custom(ContentComponent.regular, size: 24))
                .padding(.bottom, -15)
                .padding(.leading, 41)
        }
    }
}
