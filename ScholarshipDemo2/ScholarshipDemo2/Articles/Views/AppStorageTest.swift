//
//  AppStorageTest.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct AppStorageTest: View {
    @AppStorage("text") var isOnboardingActive = true
    @Binding var departmentNamee : String
    var body: some View {
        if isOnboardingActive {
            OnboardingDemo(isOnboardingActive: $isOnboardingActive)
        } else {
            MoneyView(isOnboardingActive: $isOnboardingActive, departmentNamee: $departmentNamee)
        }
        
    }
}

//struct AppStorageTest_Previews: PreviewProvider {
//    static var previews: some View {
//        AppStorageTest()
//    }
//}
