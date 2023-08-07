//
//  NextButton.swift
//  witchie
//
//  Created by Guilherme Souza on 06/08/23.
//

import SwiftUI

struct NextButton: View {
    
    var color: String
    var funcToDo: ()->()
    
    var body: some View {
        Button {
            funcToDo()
        } label: {
            HStack {
                Image(systemName: "arrow.forward").font(.custom(ContentComponent.regular, size: 40))
                    .underline()
                    .foregroundColor(Color(color))
                    .padding(.bottom, -10)
            }
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(color: ColorAsset.WHITE){
            
        }
    }
}


