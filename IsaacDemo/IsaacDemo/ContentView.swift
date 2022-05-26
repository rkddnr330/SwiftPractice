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
    
    var body: some View {
        NavigationView {
            List(words, id:\.self) { word in
                NavigationLink(destination: WordDetailView(word :$words[0])) {
                    Text(word)
                        .padding()
                }
            }
            .navigationTitle("Words List")
            .task{
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        //create url
        guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=20") else {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
