//
//  IntroView.swift
//  IsaacDemo
//
//  Created by Park Kangwook on 2022/05/27.
//

import SwiftUI

struct IntroView: View {
    @State private var wordsCount: Double = 0
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("단어 개수를 입력하세요 🥸")
                    .font(.title)
//                Slider(value: $wordsCount, in: 0...15, step: 1)
                HStack {
                    TextField("1이상 15이하 숫자 입력", value: $wordsCount, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200, alignment: .center)
                        .padding()
                    Button (action: {
                        if wordsCount < 1 || wordsCount > 15 {
                            showingAlert = true
                        }
                    }) {
                        if wordsCount < 1 || wordsCount > 15 {
                            Text("단어 확인")
                        } else {
                            NavigationLink(destination: ContentView(wordsCount: $wordsCount)){
                                Text("단어 확인")
                            }
                        }
                    }
                    .alert("1이상 15 이하의 단어만 입력해주세요!", isPresented: $showingAlert) {
                        Button("확인", role: .cancel) { }
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
