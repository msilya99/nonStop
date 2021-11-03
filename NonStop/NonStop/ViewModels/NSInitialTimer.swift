//
//  NSInitialTimer.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import Combine
import UIKit

class NSInitialTimer: ObservableObject {

    // MARK: - published variables

    @Published var timeRemaining: TimeInterval = 0

    // MARK: - variables

    private var timer = Timer()
    private var isTimerStarted: Bool = false

    private let currentDate = Date()
    var startDate: Date { return currentDate.adding(.minute, value: -30) }
    var endDate: Date { return currentDate.adding(.minute, value: 30) }

    // MARK: - timer actions

    func startTimer() {
        guard !isTimerStarted else { return }
        isTimerStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.timeRemaining = self.endDate - Date()
        }
    }

    func stopTimer() {
        timer.invalidate()
    }

    func stopTimerAndReset() {
        timer.invalidate()
        isTimerStarted = false
        timeRemaining = 0
    }

    // MARK: - getters

    func getStartDateString() -> String {
        return startDate.toString(format: DateTimeFormat.timeUserViewFormat)
    }

    func getEndDateString() -> String {
        return endDate.toString(format: DateTimeFormat.timeUserViewFormat)
    }
}
