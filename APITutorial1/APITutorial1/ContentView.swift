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
                ///await : async function에서 구체적인 suspension point를 알려주는 역할
                ///이 지점에서 비동기적인 작업(스레드에서 빠져서 백그라운드에서 작업을 진행하자! 잠깐 빠져있어! 그리고 다 되면 여기서 다시 시작하자!)이 이루어진다는 것을 알린다
                await fetchData()
            }
        }
    }
    
    ///API 활용해서 data 가져오는 함수
    ///fetchData 함수는 async : 비동기 함수다
    func fetchData() async {
        //create url
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else {
            print("url is invalid. try again!")
            return
        }
        //fetch data from the url
        do {                    ///await : '여기가 비동기적으로 일어나는 곳이다!' 임을 알려줌
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //decode that data
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
