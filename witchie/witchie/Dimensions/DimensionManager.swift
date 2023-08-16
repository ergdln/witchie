//
//  DimensionManager.swift
//  witchie
//
//  Created by ditthales on 10/08/23.
//

import Foundation

class DimensionManager: ObservableObject{
    
    @Published var dimensions: CGSize = CGSize(width: 0, height: 0)
    
    var orientation: DeviceOrientation{
        if dimensions.height > dimensions.width{
            return .portrait
        }else{
            return .landscape
        }
    }
    
    static var shared = DimensionManager()
    
}

enum DeviceOrientation{
    case landscape, portrait
}
