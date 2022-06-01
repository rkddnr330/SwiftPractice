//
//  ContentView.swift
//  IsaacDemo
//
//  Created by Park Kangwook on 2022/05/26.
//

import SwiftUI

struct ContentView: View {
    ///@State로 선언 : 여기에 words의 Source of Truth가 있다.
//    @State private var words = [String]()
    
    @ObservedObject var words = WordViewModel()
    @Binding var wordsCount: Double
    @State private var isShowing = false
    @State private var showingAlert = false
    
    var body: some View {
        List(words.wordList, id:\.self) { word in
            Text(word)
                .padding()
        }
        .navigationTitle("List of \(Int(wordsCount)) Words")
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    isShowing.toggle()
                }) {
                    Text("EDIT")
                }
                .sheet(isPresented: $isShowing) {
                    VStack {
                        Text("단어 개수를 수정해봅시다 🧐")
                        HStack {
                            TextField("1이상 15이하 숫자 입력", value: $wordsCount, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 200, alignment: .center)
                                .padding()
                            Button (action: {
                                if wordsCount < 1 || wordsCount > 15 {
                                    showingAlert = true
                                } else {
                                    Task {
                                        await words.fetchData(Int(wordsCount))
                                    }
                                    isShowing.toggle()
                                }
                            
                            }) {
                                Text("단어 확인")
                            }
                            .alert("1이상 15 이하의 개수만 입력해주세요!", isPresented: $showingAlert) {
                                Button("확인", role: .cancel) { }
                            }
                        }
                    }
                }
            }
        }
        .task{
            await words.fetchData(Int(wordsCount))
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    @Binding var wordsCount: Double
//    static var previews: some View {
//        ContentView(wordsCount: wordsCount)
//    }
//}
