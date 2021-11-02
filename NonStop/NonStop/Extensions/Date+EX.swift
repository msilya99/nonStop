//
//  Date+EX.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import UIKit

extension Date {

    /// SwifterSwift: Date by adding multiples of calendar component.
    ///
    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of components to add.
    /// - Returns: original date + multiples of component added.
    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return Calendar.current.date(byAdding: component, value: value, to: self)!
    }

    /// SwifterSwift: Add calendar component to date.
    ///
    ///     var date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
    ///     date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
    ///     date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
    ///     date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenet to add.
    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = Calendar.current.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    func toString(format: String = DateTimeFormat.baseUserViewFormat,
                  timeZoneAbbreviation: String? = nil,
                  withCurrentLocale: Bool = false,
                  truncateLeadingZero: Bool = false) -> String {
        let formatter = DateFormatter()
        let timeZone = TimeZone(abbreviation: timeZoneAbbreviation ?? "") ?? SYS.timeZone
        formatter.timeZone = timeZone
        formatter.dateFormat = format
        if withCurrentLocale {
            formatter.locale = Locale(identifier: SYS.langCode.rawValue)
        }

        var resultString = formatter.string(from: self)

        if truncateLeadingZero, resultString.hasPrefix("0") {
            resultString.removeFirst()
        }

        return resultString
    }
}
