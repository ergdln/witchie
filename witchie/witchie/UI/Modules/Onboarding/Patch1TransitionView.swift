//
//  OnboardingView.swift
//  witchie
//
//  Created by Guilherme Souza on 07/08/23.
//

import SwiftUI

struct Patch1TransitionView: View {
    @State var transitionNumber = 1
    var safeDimensionManager = DimensionManager.shared
    var body: some View {
        VStack {
            
            //MARK: ONBOARDING 1
            if transitionNumber == 1 {
                Patch1Transition1() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 2
            if transitionNumber == 2 {
                Patch1Transition2() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 3
            if transitionNumber == 3 {
                Patch1Transition3() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 4
            if transitionNumber == 4 {
                Patch1Transition4() {
                    transitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 5
            if transitionNumber == 5 {
                Patch1Transition5(){
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
