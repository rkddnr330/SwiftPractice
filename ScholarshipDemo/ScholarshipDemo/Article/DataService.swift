//
//  DataService.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/04.
//

import Foundation
import SwiftSoup

class DataService: ObservableObject{
    
    @Published var articleList = [Article]()
    
//    let baseURL = URL(string: "https://www.swiftbysundell.com")
    let baseURL = URL(string: "https://www.pusan.ac.kr/kor/CMS/Board/Board.do?mCode=MN095")
    
    
    func fetchArticles(){
        articleList.removeAll()
        
//        이 코드의 의미 : 위에서 선언한 baseURL 뒤에 articles라고 주소창 더 붙임 == 새로운 주소창이 된다는 의미
//        그니까 받아오는 url이 https://www.swiftbysundell.com/articles 가 되는 거임
//        let articleURL = baseURL?.appendingPathComponent("/articles")
//
        let articleURL = baseURL
//        print("🥶\(articleURL)")
        
        if let articleURL = articleURL{
            do {
                let websiteString = try String(contentsOf: articleURL)
                print("🤢\(websiteString)")
                let document = try SwiftSoup.parse(websiteString)
                print("👤🚨🚨🚨🚨🚨🚨\(document)")
                
//                let articles = try document.getElementsByClass("item-list").select("article")
                let articles = try document.getElementsByClass("stitle")
                
                print("👿\(articles)")  //SwiftSoup.Elements
                for i in articles {
                    print("💂🏻\(i)")
                }
                
                for article in articles{
                    let title = try article.select("a").first()?.text(trimAndNormaliseWhitespace: true) ?? ""
                    
                    print("😀\(title)")     //진짜 title 나와야 함
                    
                    guard let baseURL = baseURL else {
                        return
                    }
                    
                    let url = try baseURL.appendingPathComponent(article.select("a").attr("href"))
                    let dateString = try article.select("div").select("span").text()
                        .replacingOccurrences(of: "Published on ", with: "")
                        .replacingOccurrences(of: "Remastered on ", with: "")
                        .replacingOccurrences(of: "Answered on ", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)

                    let formatter = DateFormatter(dateFormat: "dd MMM yyyy")
                    let date = Calendar.current.startOfDay(for: formatter.date(from: dateString) ?? Date.now)

                    let post = Article(title: title, url: url, publishDate: date)
                    self.articleList.append(post)
                }
                
            } catch let error {
                print(error)
            }
        }
        
    }
    
}
