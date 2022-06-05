//
//  Article.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/04.
//

import Foundation

///공지사항 각각의 글에 대한 구조
struct Article: Identifiable, Hashable{
    let id = UUID().uuidString
    var title: String
    var url : URL?
    var publishDate: Date
}
