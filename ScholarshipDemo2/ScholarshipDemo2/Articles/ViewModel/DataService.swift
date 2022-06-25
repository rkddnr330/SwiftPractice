//
//  DataService.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/07.
//

import Foundation
import SwiftSoup
import SwiftUI

class DataService: ObservableObject {

    @Published var articleList = [Article]()
    @Published var officialList = [Article]()
    
    @AppStorage("department") var currentDepartment : String = "화공생명환경공학부 환경공학전공" {
        didSet {
            fetchArticles(department: currentDepartment)
        }
    }

    ///긁어올 URL 주소
//    let baseURL = URL(string: "https://cse.pusan.ac.kr/cse/14651/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGY3NlJTJGMjYwNSUyRmFydGNsTGlzdC5kbyUzRmJic09wZW5XcmRTZXElM0QlMjZpc1ZpZXdNaW5lJTNEZmFsc2UlMjZzcmNoQ29sdW1uJTNEc2olMjZwYWdlJTNEMSUyNnNyY2hXcmQlM0QlMjZyZ3NCZ25kZVN0ciUzRCUyNmJic0NsU2VxJTNENDIyOSUyNnJnc0VuZGRlU3RyJTNEJTI2")
//    let baseURL = URL(string:DataDemo().dataDemo["정보의생명공학대학"]!["정보컴퓨터공학부"]! )
    
    
    init() {
        fetchArticles(department: currentDepartment)
    }
    
    
//    var officialURL = "https://www.pusan.ac.kr/kor/CMS/Board/Board.do"
    
    func fetchArticles(department: String) {
        
        
        articleList.removeAll()
        officialList.removeAll()

//        이 코드의 의미 : 위에서 선언한 baseURL 뒤에 articles라고 주소창 더 붙임 == 새로운 주소창이 된다는 의미
//        그니까 받아오는 url이 https://www.swiftbysundell.com/articles 가 되는 거임
//        여기서는 뒤에 붙여주는 방식으로 안하기 때문에 주석처리
//        let articleURL = baseURL?.appendingPathComponent("/cse/14651/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGY3NlJTJGMjYwNSUyRmFydGNsTGlzdC5kbyUzRmJic09wZW5XcmRTZXElM0QlMjZpc1ZpZXdNaW5lJTNEZmFsc2UlMjZzcmNoQ29sdW1uJTNEc2olMjZwYWdlJTNEMSUyNnNyY2hXcmQlM0QlMjZyZ3NCZ25kZVN0ciUzRCUyNmJic0NsU2VxJTNENDIyOSUyNnJnc0VuZGRlU3RyJTNEJTI2")

//        let articleURL = baseURL
        
//        let officialURL = officialURL
//        print("🥶\(articleURL)")
        
        
//        var offString = officialURL
//        offString.append("\(String(i))")
//        var offURL = URL(string: offString)
        
        let baseURL = URL(string:DataDemo().originURL["\(department)"]!)
        
        var articleString: String = DataDemo().originURL["\(department)"]!
        let detailStirng: String = DataDemo().detailURL["\(department)"]!
        articleString.append("\(detailStirng)")
        let articleURL = URL(string:articleString)
        print("⭕️\(articleURL)")
        print("⭕️\(baseURL)")
        if let articleURL = articleURL{
            do {
                let websiteString = try String(contentsOf: articleURL)
                print("🤢\(websiteString)")
                let document = try SwiftSoup.parse(websiteString)
                print("👤🚨🚨🚨🚨🚨🚨\(document)") //<!doctype html>

//                let articles = try document.getElementsByClass("item-list").select("article")
                ///artclTdTitle 이라는 클래스를 가진 코드 불러오기
                let articles = try document.getElementsByClass("_artclTdTitle")

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
                    
                    let dateStringa = try article.select("a").first()?.text(trimAndNormaliseWhitespace: true) ?? ""
                    print("🔥\(dateStringa)")
                    
                    let formatter = DateFormatter(dateFormat: "dd MMM yyyy")
                    let date = Calendar.current.startOfDay(for: formatter.date(from: dateString) ?? Date.now)
                    
                    let post = Article(title: title, url: url, publishDate: date)
                    if post.title.contains("장학") {
                        self.articleList.append(post)
                    }
                }
            }

            catch let error {
                print(error)
            }
        }
        
        ///학교 공홈
        var officialURL = "https://www.pusan.ac.kr/kor/CMS/Board/Board.do"
        let baseOfficialURL = URL(string:officialURL)
        var offString = "https://www.pusan.ac.kr/kor/CMS/Board/Board.do?robot=Y&mCode=MN095&searchID=title&searchKeyword=장학&mgr_seq=3&mode=list&page=1"

        guard let encodedOfficial = offString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let offURL = URL(string: encodedOfficial)
        
        if let offURL = offURL{
            do {
                let websiteString = try String(contentsOf: offURL)
                print("🤢\(websiteString)")
                let document = try SwiftSoup.parse(websiteString)
                print("👤🚨🚨🚨🚨🚨🚨\(document)")
                
                //                let articles = try document.getElementsByClass("item-list").select("article")
                ///artclTdTitle 이라는 클래스를 가진 코드 불러오기
                let articles = try document.getElementsByClass("stitle")
                
                print("👿\(articles)")  //SwiftSoup.Elements
                for i in articles {
                    print("⭕️\(i)")
                }
                for article in articles{
                    let title = try article.select("a").first()?.text(trimAndNormaliseWhitespace: true) ?? ""
                    
                    print("😀\(title)")     //진짜 title 나와야 함
                    
                    guard let baseOfficialURL = baseOfficialURL else {
                        return
                    }
                    
                    var url = try baseOfficialURL.appendingPathComponent(article.select("a").attr("href"))
                    print("🌁\(url)")
                    let changedUrl = URL(string: url.description.replacingOccurrences(of: "/%3F", with: "?"))
                    print("🌁\(changedUrl)")
//                    https://www.pusan.ac.kr/kor/CMS/Board/Board.do
                    //https://www.pusan.ac.kr/kor/CMS/Board/Board.do?mCode=MN095&page=1&searchID=title&searchKeyword=%EC%9E%A5%ED%95%99&mgr_seq=3&mode=view&mgr_seq=3&board_seq=1481006
                    //https://www.pusan.ac.kr/kor/CMS/Board/Board.do/%3FmCode=MN095&page=1&searchID=title&searchKeyword=%EC%9E%A5%ED%95%99&mgr_seq=3&mode=view&mgr_seq=3&board_seq=1473599

                    let dateString = try article.select("div").select("span").text()
                        .replacingOccurrences(of: "Published on ", with: "")
                        .replacingOccurrences(of: "Remastered on ", with: "")
                        .replacingOccurrences(of: "Answered on ", with: "")
                                                .trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let formatter = DateFormatter(dateFormat: "dd MMM yyyy")
                    let date = Calendar.current.startOfDay(for: formatter.date(from: dateString) ?? Date.now)
                    
                    let post = Article(title: title, url: changedUrl, publishDate: date)
                    if post.title.contains("장학") {
                        self.officialList.append(post)
                    }
                }
            }
            
            catch let error {
                print(error)
            }
        }
        //        }
    }
}

extension Date{
    func isInToday(date: Date) -> Bool{
        return self == date
    }
    
    func esDate() -> String{
        return self.formatted(.dateTime.day().month(.wide).year().locale(.init(identifier:"en_GB")))
    }
    
    func isOlderThanToday(date: Date) -> Bool {
        return self < date
    }
}

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(secondsFromGMT: 0)
        self.dateFormat =  dateFormat
    }
}
