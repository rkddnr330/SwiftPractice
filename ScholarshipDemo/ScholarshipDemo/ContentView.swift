//
//  ContentView.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/02.
//

import SwiftUI
import SwiftSoup

struct ContentView: View {
    var body: some View {
        Button("Go!") {
            fetchPNUHomeData()
        }
    }
    
    var carLabel: String
    
    func fetchPNUHomeData() {
        
        let urlAddress = "https://www.pusan.ac.kr/kor/CMS/Board/Board.do?mCode=MN095"
                
        guard let url = URL(string: urlAddress) else { return }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let title: Elements = try doc.select("stitle").select("a")
            
            carLabel = title
            print(carLabel)
            
        } catch let error {
            print("Error : \(error)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
