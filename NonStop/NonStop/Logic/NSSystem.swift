//
//  NSSystem.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import UIKit

let SYS = NSSystem()

class NSSystem {

    // MARK: language

    var langCode: AppLang = .ru

    // MARK: - location

    private(set) var calendar: Calendar
    private(set) var timeZone: TimeZone

    // MARK: - init

    init() {
        timeZone = TimeZone(abbreviation: DateTimeFormat.defaultTimeZone) ?? Calendar.current.timeZone
        calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = timeZone
    }
}
