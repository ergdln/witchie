//
//  PatchCard.swift
//  witchie
//
//  Created by ditthales on 12/09/23.
//

import SwiftUI

struct PatchCard: View {
    let center = UnitPoint(x: 0.6, y: 0.7)
    let gradientColor1: Color
    let gradientColor2: Color
    let bgColor: Color
    let name: String
    let stars: Int
    let image: Image
    var body: some View {
        VStack{
            Text(name)
                .font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                .padding(.bottom, -20)
            HStack{
                StarPath()
                Image(stars >= 1 ? "STAR-FILL" : "STAR")
                Spacer()
                Image(stars >= 2 ? "STAR-FILL" : "STAR")
                Spacer()
                Image(stars >= 3 ? "STAR-FILL" : "STAR")
            }
            .frame(width: 200, height: 66)
            .padding(.horizontal, 15)
            .background(bgColor)
            .cornerRadius(15)
            Spacer()
            HStack(alignment: .bottom){
                Text("1")
                    .font(.custom(ContentComponent.BOREL_REGULAR, size: 54))
                    .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                    .padding(.bottom, -20)
                Spacer()
                image
            }
            .padding(.leading, 35)
        }.frame(width: 298, height: 562)
        .padding(.top, 32)
            .background(
                AngularGradient(colors: [gradientColor1, gradientColor2],
                                center: center,
                                angle: Angle(degrees: 210))
            )
            .cornerRadius(19)
    }
}
