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
            Text("pular").font(.custom(ContentComponent.regular, size: 20))
                .underline()
                .foregroundColor(Color(color))
                .padding(.bottom, -10)
        }
        
    }
}

struct JumpButton_Previews: PreviewProvider {
    static var previews: some View {
        JumpButton(color: ColorAsset.WHITE)
    }
}

