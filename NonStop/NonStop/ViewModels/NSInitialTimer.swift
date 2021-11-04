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
    private var isTimerStarted: Bool = false

    private let currentDate = Date()
    var startDate: Date { return currentDate.adding(.second, value: -10) }
    var endDate: Date { return currentDate.adding(.second, value: 50) }

    // MARK: - timer actions

    func startTimer() {
        guard !isTimerStarted else { return }
        isTimerStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let now = Date()
            guard now > self.startDate else { return }
            self.timeRemain = self.endDate - now
            if self.timeRemain <= 0 {
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
        return startDate.toString(format: DateTimeFormat.timeUserViewFormat)
    }

    func getEndDateString() -> String {
        return endDate.toString(format: DateTimeFormat.timeUserViewFormat)
    }

    func getTimeRemainString() -> String {
        return Date(timeIntervalSinceReferenceDate: timeRemain)
            .toString(format: DateTimeFormat.fullTime)
    }

    // MARK: - actions

    private func updateTimeRemainingPersentageIfNeeded() {
        guard timeLeftPersentage < 100 else { return }
        let intervalFromStartToEnd = endDate - startDate
        let newTimeRemaingPersentage = (timeRemain / intervalFromStartToEnd) * 100
        timeLeftPersentage = 100 - newTimeRemaingPersentage
    }
}
