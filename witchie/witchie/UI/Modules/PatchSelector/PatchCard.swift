//
//  PatchCard.swift
//  witchie
//
//  Created by ditthales on 12/09/23.
//

import SwiftUI

struct DimensionsConfig{
    let card: CGSize
    let stars: CGSize
    let starContainer: CGSize
}

struct PatchCard: View {
    let center = UnitPoint(x: 0.6, y: 0.7)
    let gradientColor1: Color
    let gradientColor2: Color
    let bgColor: Color
    let name: String
    let stars: Int
    let image: Image
    let patch: Int
    
    @ObservedObject var viewModel = PatchSelectorViewModel()
    
    var body: some View {
        VStack{
            Text(name)
                .font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                .padding(.bottom, -20)
            HStack{
                StarPath(color: stars >= 1 ? .yellow : gradientColor1.opacity(0.5))
                    .frame(width: viewModel.getScreenSize().stars.width, height: viewModel.getScreenSize().stars.height)
                Spacer()
                StarPath(color: stars >= 2 ? .yellow : gradientColor1.opacity(0.5))
                    .frame(width: viewModel.getScreenSize().stars.width, height: viewModel.getScreenSize().stars.height)
                Spacer()
                StarPath(color: stars >= 3 ? .yellow : gradientColor1.opacity(0.5))
                    .frame(width: viewModel.getScreenSize().stars.width, height: viewModel.getScreenSize().stars.height)
            }
            .frame(width: viewModel.getScreenSize().starContainer.width, height: viewModel.getScreenSize().starContainer.height)
            .padding(.horizontal, 15)
            .background(bgColor)
            .cornerRadius(15)
            Spacer()
            HStack(alignment: .bottom){
                Text(String(patch))
                    .font(.custom(ContentComponent.BOREL_REGULAR, size: 54))
                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                    .padding(.bottom, -20)
                Spacer()
                image
            }
            .padding(.leading, 35)
        }.frame(width: viewModel.getScreenSize().card.width, height: viewModel.getScreenSize().card.height)
        .padding(.top, 32)
            .background(
                AngularGradient(colors: [gradientColor1, gradientColor2],
                                center: center,
                                angle: Angle(degrees: 210))
            )
            .cornerRadius(19)
    }
}
