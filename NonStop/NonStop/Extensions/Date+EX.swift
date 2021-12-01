//
//  Date+EX.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import UIKit
import Foundation

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
        return SYS.calendar.date(byAdding: component, value: value, to: self)!
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
        if let date = SYS.calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    /// SwifterSwift: Year.
    ///
    ///        Date().year -> 2017
    ///
    ///        var someDate = Date()
    ///        someDate.year = 2000 // sets someDate's year to 2000
    ///
    var year: Int {
        get {
            return SYS.calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = SYS.calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = SYS.calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    /// SwifterSwift: Month.
    ///
    ///     Date().month -> 1
    ///
    ///     var someDate = Date()
    ///     someDate.month = 10 // sets someDate's month to 10.
    ///
    var month: Int {
        get {
            return SYS.calendar.component(.month, from: self)
        }
        set {
            let allowedRange = SYS.calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentMonth = SYS.calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = SYS.calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    /// SwifterSwift: Day.
    ///
    ///     Date().day -> 12
    ///
    ///     var someDate = Date()
    ///     someDate.day = 1 // sets someDate's day of month to 1.
    ///
    var day: Int {
        get {
            return SYS.calendar.component(.day, from: self)
        }
        set {
            let allowedRange = SYS.calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = SYS.calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = SYS.calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    /// SwifterSwift: Hour.
    ///
    ///     Date().hour -> 17 // 5 pm
    ///
    ///     var someDate = Date()
    ///     someDate.hour = 13 // sets someDate's hour to 1 pm.
    ///
    var hour: Int {
        get {
            return SYS.calendar.component(.hour, from: self)
        }
        set {
            guard let allowedRange = SYS.calendar.range(of: .hour, in: .day, for: self),
                  allowedRange.contains(newValue) else { return }
            let currentHour = SYS.calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = SYS.calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    /// SwifterSwift: Minutes.
    ///
    ///     Date().minute -> 39
    ///
    ///     var someDate = Date()
    ///     someDate.minute = 10 // sets someDate's minutes to 10.
    ///
    var minute: Int {
        get {
            return SYS.calendar.component(.minute, from: self)
        }
        set {
            guard let allowedRange = SYS.calendar.range(of: .minute, in: .hour, for: self),
                  allowedRange.contains(newValue) else { return }
            let currentMinutes = SYS.calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = SYS.calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    /// SwifterSwift: Seconds.
    ///
    ///     Date().second -> 55
    ///
    ///     var someDate = Date()
    ///     someDate.second = 15 // sets someDate's seconds to 15.
    ///
    var second: Int {
        get {
            return SYS.calendar.component(.second, from: self)
        }
        set {
            guard let allowedRange = SYS.calendar.range(of: .second, in: .minute, for: self), allowedRange.contains(newValue) else { return }
            let currentSeconds = SYS.calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = SYS.calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    func toString(format: String = DateTimeFormat.baseUserViewFormat,
                  timeZoneAbbreviation: String? = nil,
                  withCurrentLocale: Bool = true,
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

    static func rangeFormat(start: Date, end: Date, format: String) -> String {
        return "\(start.string(withFormat: format))-\(end.string(withFormat: format))"
    }

    func string(withFormat format: String = DateTimeFormat.dayMonthTimeLongFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func startDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }

    func endDay() -> Date {
        return startDay()
            .adding(.day, value: 1)
            .adding(.second, value: -1)
    }

    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    static func getIntervalValueString(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        var dateFormat: String
        switch (date.hour, date.minute, date.second) {
        case (let hour, let minute , _) where hour == 0 && minute > 0:
            dateFormat = DateTimeFormat.minutesAndSeconds
        case (let hour, let minute , let second) where hour == 0 && minute == 0 && second >= 0:
            dateFormat = DateTimeFormat.seconds
        default:
            dateFormat = DateTimeFormat.fullTime
        }
        return date.toString(format: dateFormat,
                             timeZoneAbbreviation: DateTimeFormat.defaultTimeZone)
    }

    static func getHourAndMinuteIntervalString(_ timeInterval: TimeInterval,
                                               withDays: Bool = false) -> String {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        var dateString = ""
        if withDays, date.day > 1 { dateString += "\(date.day - 1) d" }
        if date.hour > 0 { dateString += " \(date.hour) h" }
        if date.minute > 0 { dateString += " \(date.minute) min" }
        if (date.day - 1) == 0, date.hour == 0, date.minute == 0 { dateString += "1 d" }
        return dateString
    }

    static func getTimeStringForInterval(_ timeInterval: TimeInterval,
                                         format: String) -> String {
        let date = Date(timeIntervalSinceReferenceDate: timeInterval)
        return date.toString(format: format,
                             timeZoneAbbreviation: DateTimeFormat.defaultTimeZone)
    }

    static func getCurrentDate() -> Date {
        guard let timezoneOffset = TimeZone(abbreviation: DateTimeFormat.defaultTimeZone)?.secondsFromGMT() else { return Date() }
        let epochDate = Date().timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))

        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }

    func isInTimeInterval(fromDate: Date, toDate: Date) -> Bool {
        var startDate = fromDate
        var endDate = toDate

        startDate.day = self.day
        startDate.month = self.month
        startDate.year = self.year

        endDate.day = self.day
        endDate.month = self.month
        endDate.year = self.year

        return startDate...endDate ~= self
    }
}
