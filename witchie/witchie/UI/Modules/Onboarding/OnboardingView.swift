//
//  OnboardingView.swift
//  witchie
//
//  Created by Guilherme Souza on 07/08/23.
//

import SwiftUI

struct OnboardingView: View {
    @State var OnboardingNumber = 1
    var safeDimensionManager = DimensionManager.shared
    var body: some View {
        VStack {
            
            //MARK: ONBOARDING 1
            if OnboardingNumber == 1 {
                Onboarding1() {
                    OnboardingNumber += 1
                }
            }
            
            //MARK: ONBOARDING 2
            if OnboardingNumber == 2 {
                Onboarding2() {
                    OnboardingNumber += 1
                }
            }
            
            //MARK: ONBOARDING 3
            if OnboardingNumber == 3 {
                Onboarding3() {
                    OnboardingNumber += 1
                }
            }
            
            //MARK: ONBOARDING 4
            if OnboardingNumber == 4 {
                Onboarding4() {
                    OnboardingNumber += 1
                }
            }
            
            //MARK: ONBOARDING 5
            if OnboardingNumber == 5 {
                Onboarding5()
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
