//
//  BackButton.swift
//  witchie
//
//  Created by ditthales on 04/08/23.
//

import SwiftUI

struct BackButton: View {
    
    var color: String
    var funcToDo: ()->()
    
    var body: some View {
        Button{
            funcToDo()
        }label: {
            HStack {
                if color == ColorAsset.MAIN_PURPLE{
                    Image(ImageAsset.ARROW_PURPLE)
                }else if color == ColorAsset.MAIN_WHITE{
                    Image(ImageAsset.ARROW_WHITE)
                }
                Text(ContentComponent.BACK).font(.custom(ContentComponent.BOREL_REGULAR, size: 20))
                    .underline()
                    .foregroundColor(Color(color))
                    .padding(.bottom, -10)
            }
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(color: ColorAsset.MAIN_PURPLE){
            
        }
    }
}
