//
//  AnimatedOnboarding.swift
//  witchie
//
//  Created by ditthales on 16/08/23.
//

import Foundation
import SwiftUI

struct AnimatingImage: View {
        //pega aquele [Image] la de cima e atribui pra essa let
         let images: [Image]
         
        //recebe sucessivamente o valor de Counter no intervalo q vc inserir (é um número, tá explicado melhor em baixo)
         @ObservedObject private var counter = Counter(interval: 0.1)
         
         var body: some View {
             //acessa o [Image] na posição abaixo (vai variando de 0 até o final por essa operação aí que pega o resto da divisão do valor do counter pela quantidade de frames)
             images[counter.value % images.count]
                 .resizable()
                 .scaledToFit()
             
         }
}

private class Counter: ObservableObject {
         private var timer: Timer?
         
         @Published var value: Int = 0
         
         init(interval: Double) {
             timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in self.value += 1 }
         }
}
