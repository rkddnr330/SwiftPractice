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
                            Text("단어 개수: \(Int(wordsCount))")
                            Slider(value: $wordsCount, in: 0...15, step: 1)
                            
                            Button (action: {
                                isShowing.toggle()
                                
                            }) {
//                                NavigationLink(destination: ContentView(wordsCount: $wordsCount)){
                                    Text("단어 확인")
//                                }
                            }
                        }
                    }
                    .task {
                        await fetchData(Int(wordsCount))
                    }
//                    .toolbar{
//                        ToolbarItem(placement: .confirmationAction) {
//                            Button(action: {
//                                isShowing.toggle()
//                            }) {
//                                Text("DONE")
//                            }
//                        }
//                    }
                    
                    }
            }
            .task{
                await fetchData(Int(wordsCount))
            }
        
    }
    
    func fetchData(_ wordsCount: Int) async {
        //create url
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=\(wordsCount)") else {
            print("url is invalid!")
            return
        }
        
        //fetch the data from url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            //decode that data
            if let decodedResponse = try? JSONDecoder().decode([String].self, from: data) {
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
