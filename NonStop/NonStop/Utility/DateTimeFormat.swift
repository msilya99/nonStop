//
//  DateTimeFormat.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

struct DateTimeFormat {
    static let dayMonthFormat: String = "dd.MM"
    static let dayMonthLongFormat: String = "dd MMMM"
    static let dayMonthYearLongFormat: String = "dd MMMM yyyy"
    static let dayMonthTimeLongFormat: String = "dd MMMM HH:mm"
    static let monthLongFormat: String = "LLLL"
    static let dayShortFormat: String = "d"
    static let weekdayShortFormat: String = "EEEEEE"
    static let monthYearLongFormat: String = "LLLL yyyy"
    static let dateWithTimeLongFormat: String = "dd MMMM yyyy; HH:mm"
    static let dateWithTimeLongWithCommaFormat: String = "dd.MM.yyyy, HH:mm"
    static let baseUserViewFormat: String = "dd.MM.yyyy"
    static let baseShortUserViewFormat: String = "dd.MM.yy"
    static let hoursAndMinutes: String = "HH:mm"
    static let defaultTimeZone: String = "UTC"
    static let yearFormat: String = "yyyy"
    static let fullTime: String = "HH:mm:ss"
    static let minutesAndSeconds: String = "mm:ss"
    static let seconds: String = "ss"
}
