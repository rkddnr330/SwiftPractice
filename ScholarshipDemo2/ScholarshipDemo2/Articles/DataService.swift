//
//  DataService.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/07.
//

import Foundation
import SwiftSoup

class DataService: ObservableObject{
    
    @Published var articleList = [Article]()
    let baseURL = URL(string: "https://newwave.tistory.com/")
    
    
    func fetchArticles(){
        articleList.removeAll()
//        let articleURL = baseURL?.appendingPathComponent("articles")
        let articleURL = baseURL
        
        if let articleURL = articleURL{
            do {
                let websiteString = try String(contentsOf: articleURL)
                let document = try SwiftSoup.parse(websiteString)
                
                let articles = try document.getElementsByClass("box_contents")
                for article in articles {
                    print("🚕\(article)")
                }
                
                for article in articles{
                    let title = try article.select("a").first()?.text(trimAndNormaliseWhitespace: true) ?? ""
                    guard let baseURL = baseURL else {
                        return
                    }
                    let url = try baseURL.appendingPathComponent(article.select("a").attr("href"))
                    print("🚨\(url)")
                    
//                    let dateString = try article.select("div").select("span").text()
                    let dateString = try article.select("div").select("span").last()?.text(trimAndNormaliseWhitespace: true) ?? ""
                        .replacingOccurrences(of: "Published on ", with: "")
                        .replacingOccurrences(of: "Remastered on ", with: "")
                        .replacingOccurrences(of: "Answered on ", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    print("🚧\(dateString)")
                    
                    let formatter = DateFormatter(dateFormat: "dd MMM yyyy")
                    let date = Calendar.current.startOfDay(for: formatter.date(from: dateString) ?? Date.now)
//                    print("🌁\(date)")
                    
                    let post = Article(title: title, url: url, publishDate: date)
                    self.articleList.append(post)
                }
                
            } catch let error {
                print(error)
            }
        }
        
        print("\(articleList[0].publishDate)")
    }
    
}
