//
//  NSInitialTimer.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import Combine
import UIKit

class NSInitialTimer: ObservableObject {

    // MARK: - variables

    private let currentDate = Date()
    var startDate: Date { return currentDate.adding(.minute, value: -30) }
    var endDate: Date { return currentDate.adding(.minute, value: 30) }

    func getStartDateString() -> String {
        return startDate.toString(format: DateTimeFormat.timeUserViewFormat)
    }

    func getEndDateString() -> String {
        return endDate.toString(format: DateTimeFormat.timeUserViewFormat)
    }
}
