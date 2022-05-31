//
//  WordData.swift
//  IsaacDemo
//
//  Created by Park Kangwook on 2022/05/31.
//

import Foundation

class WordViewModel: ObservableObject {
    @Published var wordList: [String]
    
    init() {
        wordList = []
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
                /// Decoding한 데이터를 wordList에 선언
                wordList = decodedResponse
            }
            
        } catch {
            print("data is invalid!")
        }
    }
}
