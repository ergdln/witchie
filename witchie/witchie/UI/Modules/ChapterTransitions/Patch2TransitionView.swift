//
//  Patch2TransitionView.swift
//  witchie
//
//  Created by egln on 13/09/23.
//


import SwiftUI

struct Patch2TransitionView: View {
    @State var TransitionNumber = 1
    var safeDimensionManager = DimensionManager.shared
    var body: some View {
        VStack {
            
            //MARK: ONBOARDING 1
            if TransitionNumber == 1 {
                Patch2Transition1() {
                    TransitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 2
            if TransitionNumber == 2 {
                Patch2Transition2() {
                    TransitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 3
            if TransitionNumber == 3 {
                Patch2Transition3() {
                    TransitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 4
            if TransitionNumber == 4 {
                Patch2Transition4() {
                    TransitionNumber += 1
                }
            }
            
            //MARK: ONBOARDING 5
            if TransitionNumber == 5 {
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
