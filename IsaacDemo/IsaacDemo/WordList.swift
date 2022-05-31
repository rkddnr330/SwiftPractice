////
////  WordList.swift
////  IsaacDemo
////
////  Created by Park Kangwook on 2022/05/30.
////
//
//import Foundation
//
//class words: ObservableObject {
//    var word: String
//    
//    init() {
//        
//    }
//}
//
//func fetchData(_ wordsCount: Int, _ words: [String]) async {
//    print("fetchData function call")
//    //create url
//    guard let url = URL(string: "https://random-word-api.herokuapp.com/word?number=\(wordsCount)") else {
//        print("url is invalid!")
//        return
//    }
//    
//    //fetch the data from url (URLSession)
//    do {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        
//        //decode that data (JSONDecoder)
//        if let decodedResponse = try? JSONDecoder().decode([String].self, from: data) {
//            /// Decoding한 데이터를 words에 선언
//            var words = decodedResponse
//        }
//    } catch {
//        print("data is invalid!")
//    }
//    
//}
