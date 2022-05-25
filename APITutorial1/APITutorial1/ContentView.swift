//
//  ContentView.swift
//  APITutorial1
//
//  Created by Park Kangwook on 2022/05/25.
//

import SwiftUI

///Quote 타입 생성
struct Quote: Codable {
    var id: Int
    var quote_id: String
    var quote: String
    var author: String
    var series: String
}

struct ContentView: View {
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationView {
            List(quotes, id : \.quote_id) { quote in
                VStack {
                    Text(quote.author)
                        .font(.headline)
                        .foregroundColor(.blue)
                    Text(quote.quote)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
            }
            .navigationTitle("Quotes")
            .task {
                await fetchData()
            }
        }
    }
    
    ///API 활용해서 data 가져오는 함수
    func fetchData() async {
        ///create url
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else {
            print("url is invalid. try again!")
            return
        }
        ///fetch data from the url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            ///decode that data
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from:data) {
                quotes = decodedResponse
            }
        } catch {
            print("data is invalid")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
