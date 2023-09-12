//
//  PatchCard.swift
//  witchie
//
//  Created by ditthales on 12/09/23.
//

import SwiftUI

struct PatchCard: View {
    let center = UnitPoint(x: 0.6, y: 0.7)
    let gradientColor1 = Color(red: 23/255, green: 10/255, blue: 44/255)
    let gradientColor2 = Color(red: 60/255, green: 20/255, blue: 111/255)
    let bgColor = Color(red: 41/255, green: 27/255, blue: 83/255)
    var body: some View {
        VStack{
            Text("Covil")
                .font(.custom(ContentComponent.BOREL_REGULAR, size: 40))
                .foregroundColor(Color(ColorAsset.MAIN_WHITE))
                .padding(.bottom, -20)
            HStack{
                Image("STAR")
                Spacer()
                Image("STAR")
                Spacer()
                Image("STAR")
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
                Image("IMAGE-PATCH1")
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

struct PatchCard_Previews: PreviewProvider {
    static var previews: some View {
        PatchCard()
    }
}
