//
//  PatchModel.swift
//  Witchie
//
//  Created by ditthales on 05/10/23.
//

import Foundation

struct PatchModel {
    func getPatchAssets(patch: Int, images: [String]) -> String {
        guard patch >= 1 && patch <= images.count else {
            return "default_image" //caso seja um valor de patch inválido
        }
        return images[patch - 1] //subtrai 1 do patch para corresponder ao índice do array
    }
}
