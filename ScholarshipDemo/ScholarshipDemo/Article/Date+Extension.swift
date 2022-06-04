//
//  Date+Extension.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/04.
//
import Foundation

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
