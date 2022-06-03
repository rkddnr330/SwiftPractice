//
//  ViewController.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/03.
//

//import Foundation
//import SwiftSoup
//
//class Data {
//    var data: [String]
//    
//    init() {
//        data = [""]
//    }
//    
//    func fetchPNUHomeData() {
//        
//        let urlAddress = "https://www.pusan.ac.kr/kor/CMS/Board/Board.do?mCode=MN095"
//                
//        guard let url = URL(string: urlAddress) else { return }
//        
//        do {
//            let html = try String(contentsOf: url, encoding: .utf8)
//            let doc: Document = try SwiftSoup.parse(html)
//            
//            let title: Elements = try doc.select("stitle").select("a")
//            print(title)
//            
//        } catch let error {
//            print("Error : \(error)")
//        }
//        
//    }
//}
//
