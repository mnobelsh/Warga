//
//  Date.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import Foundation

extension Date {
    
    public enum FormatType: String {
        case dayFullString = "EEEE"
        case dayAbbrevationString = "E"
        case dayInt = "dd"
        case monthFullString = "MMMM"
        case monthAbbrevationString = "MMM"
        case monthInt = "MM"
        case year = "yyyy"
        case hour = "HH"
        case minute = "mm"
        case second = "ss"
        case meridiem = "a"
        case dash = "-"
        case slash = "/"
        case dot = "."
        case colon = ":"
        case comma = ","
        case whiteSpace = " "
        case t = "'T'"
    }
    
    
    func toString(format: [FormatType]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = format.map { $0.rawValue }.joined()
        return dateFormatter.string(from: self)
    }
    
    static func toDate(from string: String, withFormat format: [FormatType]) -> Date? {
        return Date.toDate(from: string, withFormat: format.map { $0.rawValue }.joined())
    }
    
    static func toDate(from string: String, withFormat stringFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateFormat = stringFormat
        return dateFormatter.date(from: string)
    }
    
    static func isoDate(from string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.formatOptions.insert(.withFractionalSeconds)
        return dateFormatter.date(from: string)
    }
}
