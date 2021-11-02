//
//  DateTimeFormat.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

struct DateTimeFormat {
    /// "dd.MM"
    static let dayMonthFormat: String = "dd.MM"
    /// "dd MMMM"
    static let dayMonthLongFormat: String = "dd MMMM"
    /// "dd MMMM YYYY"
    static let dayMonthYearLongFormat: String = "dd MMMM yyyy"
    /// "dd MMMM HH:mm"
    static let dayMonthTimeLongFormat: String = "dd MMMM HH:mm"
    /// "LLLL"
    static let monthLongFormat: String = "LLLL"
    /// "d"
    static let dayShortFormat: String = "d"
    /// "EEEEEE"
    static let weekdayShortFormat: String = "EEEEEE"
    /// "LLLL YYYY"
    static let monthYearLongFormat: String = "LLLL yyyy"
    /// "dd MMMM yyyy; HH:mm"
    static let dateWithTimeLongFormat: String = "dd MMMM yyyy; HH:mm"
    /// "dd.MM.yyyy, HH:mm"
    static let dateWithTimeLongWithCommaFormat: String = "dd.MM.yyyy, HH:mm"
    /// "dd.MM.yyyy"
    static let baseUserViewFormat: String = "dd.MM.yyyy"
    /// "dd.MM.yy"
    static let baseShortUserViewFormat: String = "dd.MM.yy"
    /// "HH:mm"
    static let timeUserViewFormat: String = "HH:mm"
    /// "+3"
    static let parseTimeZone: String = "+3"
    /// "UTC"
    static let defaultTimeZone: String = "UTC"
    /// yyyy
    static let yearFormat: String = "yyyy"
}
