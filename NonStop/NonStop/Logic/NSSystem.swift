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
        self.timeZone = Calendar.current.timeZone
        self.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = self.timeZone
    }
}
