//
//  PickerTest.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/23.
//

import SwiftUI

struct PickerTest: View {
    @Binding var isOnboardingActive : Bool
    @State private var selectedItem: Int = 0
    var list = ["A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E","A","B","C","D","E",]
    
    var body: some View {
        VStack {
            Text("온보딩 화면입니다. picker 나오면 됨")
//            Menu {
            Picker("Color", selection: $selectedItem) {
                            Text("Red")
                            Text("Blue")
                            Text("Green")
                Text("Red")
                Text("Blue")
                Text("Green")
                Text("Red")
                Text("Blue")
                Text("Green")
                Text("Green")
                
                
                        }
            Button {
                isOnboardingActive = false
            } label: {
                Text("Go Go!@")
            }
        }
    }
}
//
//struct PickerTest_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerTest()
//    }
//}
