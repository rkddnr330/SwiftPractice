//
//  AppStorageTest.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct AppStorageTest: View {
    @AppStorage("text") var isOnboardingActive = true
    var body: some View {
        if isOnboardingActive {
            OnboardingDemo(isOnboardingActive: $isOnboardingActive)
        } else {
            MoneyView(isOnboardingActive: $isOnboardingActive)
        }
        
    }
}

//struct AppStorageTest_Previews: PreviewProvider {
//    static var previews: some View {
//        AppStorageTest()
//    }
//}
