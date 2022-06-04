//
//  Article.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/04.
//

import Foundation

struct Article: Identifiable, Hashable{
    let id = UUID().uuidString
    var title: String
    var url : URL?
    var publishDate: Date
}
