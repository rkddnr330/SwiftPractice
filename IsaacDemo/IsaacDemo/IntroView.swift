//
//  IntroView.swift
//  IsaacDemo
//
//  Created by Park Kangwook on 2022/05/27.
//

import SwiftUI

struct IntroView: View {
    @State private var wordsCount: Double = 0
    var body: some View {
        NavigationView {
            VStack {
                Text("단어 개수: \(Int(wordsCount))")
                Slider(value: $wordsCount, in: 0...15, step: 1)
                
                Button (action: {}) {
                    NavigationLink(destination: ContentView(wordsCount: $wordsCount)){
                        Text("단어 확인")
                    }
                }
                
            }
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
