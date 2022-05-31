//
//  ContentView.swift
//  IsaacDemo
//
//  Created by Park Kangwook on 2022/05/26.
//

import SwiftUI

struct ContentView: View {
    ///@State로 선언 : 여기에 words의 Source of Truth가 있다.
    @State private var words = [String]()
    @Binding var wordsCount: Double
    @State private var isShowing = false
    
    var body: some View {
        List(words, id:\.self) { word in
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
//                        Slider(value: $wordsCount, in: 0...15, step: 1)
                        HStack {
                            TextField("1이상 15이하 숫자 입력", value: $wordsCount, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 200, alignment: .center)
                                .padding()
                            Button (action: {
                                print(wordsCount)
                                Task {
                                    await fetchData(Int(wordsCount))
                                }
                                isShowing.toggle()
                            }) {
                                Text("단어 확인")
                            }
                        }
                    }
                }
            }
        }
        .task{
            await fetchData(Int(wordsCount))
        }
    }
    
    func fetchData(_ wordsCount: Int) async {
        print("fetchData function call")
        //create url
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=\(wordsCount)") else {
            print("url is invalid!")
            return
        }
        //fetch the data from url (URLSession)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode that data (JSONDecoder)
            if let decodedResponse = try? JSONDecoder().decode([String].self, from: data) {
                /// Decoding한 데이터를 words에 선언
                words = decodedResponse
            }
        } catch {
            print("data is invalid!")
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    @Binding var wordsCount: Double
//    static var previews: some View {
//        ContentView(wordsCount: wordsCount)
//    }
//}
