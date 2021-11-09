//
//  NSInitialTimer.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import Combine
import UIKit
import SwiftUI

class NSInitialTimer: ObservableObject {

    // MARK: - published variables

    @Published var timeRemain: TimeInterval = 0 {
        didSet {
            updateTimeRemainingPersentageIfNeeded()
        }
    }
    @Published var timeLeftPersentage: Double = 0

    // MARK: - variables

    private var timer = Timer()
    private(set) var isTimerStarted: Bool = false

    private let fullyCompleteValue: Double = 100
    private let currentDate = Date()

    var startDate: Date { return currentDate.adding(.second, value: -10) }
    var endDate: Date { return currentDate.adding(.second, value: 20) }

    // MARK: - timer actions

    func startTimer() {
        guard !isTimerStarted else { return }
        isTimerStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let now = Date()
            guard now > self.startDate else { return }
            self.timeRemain = self.endDate - now
            if self.timeRemain < 0 {
                self.stopTimer()
            }
        }
    }

    func stopTimer() {
        timer.invalidate()
        isTimerStarted = false
        timeRemain = 0
        timeLeftPersentage = 0
    }

    // MARK: - getters

    func getStartDateString() -> String {
        return startDate.toString(format: DateTimeFormat.hoursAndMinutes)
    }

    func getEndDateString() -> String {
        return endDate.toString(format: DateTimeFormat.hoursAndMinutes)
    }

    func getTimeRemainString() -> String {
        let date = Date(timeIntervalSinceReferenceDate: timeRemain)
        var dateFormat: String
        switch (date.hour, date.minute, date.second) {
        case (let hour, let minute , _) where hour == 0 && minute > 0:
            dateFormat = DateTimeFormat.minutesAndSeconds
        case (let hour, let minute , let second) where hour == 0 && minute == 0 && second >= 0:
            dateFormat = DateTimeFormat.seconds
        default:
            dateFormat = DateTimeFormat.fullTime
        }
        return date.toString(format: dateFormat)
    }

    func getTimeRemainRatio() -> CGFloat {
        let date = Date(timeIntervalSinceReferenceDate: timeRemain)
        switch (date.hour, date.minute, date.second) {
        case (let hour, let minute , _) where hour == 0 && minute > 0:
             return 0.2
        case (let hour, let minute , let second) where hour == 0 && minute == 0 && second >= 0:
            return 0.25
        default:
            return 0.15
        }
    }

    // MARK: - actions

    private func updateTimeRemainingPersentageIfNeeded() {
        guard timeLeftPersentage < fullyCompleteValue else { return }
        let intervalFromStartToEnd = endDate - startDate
        let newTimeRemaingPersentage = (timeRemain / intervalFromStartToEnd) * 100
        timeLeftPersentage = newTimeRemaingPersentage == fullyCompleteValue
        ? fullyCompleteValue
        : fullyCompleteValue - newTimeRemaingPersentage
    }
}
