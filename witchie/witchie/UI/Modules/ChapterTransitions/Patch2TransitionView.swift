//
//  Patch2TransitionView.swift
//  witchie
//
//  Created by egln on 13/09/23.
//


import SwiftUI

struct Patch2TransitionView: View {
    @State var transitionNumber = 1
    var safeDimensionManager = DimensionManager.shared
    var body: some View {
        VStack {
            
            //MARK: ONBOARDING 1
            if transitionNumber == 1 {
                Patch2Transition1() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 2
            if transitionNumber == 2 {
                Patch2Transition2() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 3
            if transitionNumber == 3 {
                Patch2Transition3() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 4
            if transitionNumber == 4 {
                Patch2Transition4() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 5
            if transitionNumber == 5 {
                Patch2Transition5()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Patch2TansitionView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
