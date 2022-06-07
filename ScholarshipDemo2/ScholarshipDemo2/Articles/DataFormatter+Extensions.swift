//
//  DataFormatters+Extensions.swift
//  ScholarshipDemo2
//
//  Created by Park Kangwook on 2022/06/07.
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
