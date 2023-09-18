//
//  JumpButton.swift
//  witchie
//
//  Created by Guilherme Souza on 06/08/23.
//

import SwiftUI

struct JumpButton: View {
    
    var color: String
    
    var body: some View {
        HStack {
            Text(ContentComponent.JUMP).font(.custom(ContentComponent.BOREL_REGULAR, size: 20))
                .underline()
                .foregroundColor(Color(color))
                .padding(.bottom, -10)
        }
        
    }
}

struct JumpButton_Previews: PreviewProvider {
    static var previews: some View {
        JumpButton(color: ColorAsset.MAIN_WHITE)
    }
}

