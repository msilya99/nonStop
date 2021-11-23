//
//  NSSystem.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import UIKit
import SwiftUI

let SYS = NSSystem()

class NSSystem {

    @Environment(\.safeAreaInsets) private var safeAreaInsets

    // MARK: sizes

    let screenSize = UIScreen.main.bounds.size

    var tabbarHeight: CGFloat { screenSize.height / 10 }
    var safeAreaBottomInset: CGFloat { safeAreaInsets.bottom }

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
