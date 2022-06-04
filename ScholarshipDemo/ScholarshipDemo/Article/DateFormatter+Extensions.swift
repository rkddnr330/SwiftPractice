//
//  DateFormatter+Extensions.swift
//  ScholarshipDemo
//
//  Created by Park Kangwook on 2022/06/04.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(secondsFromGMT: 0)
        self.dateFormat =  dateFormat
    }
}
