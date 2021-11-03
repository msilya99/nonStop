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
    var startDate: Date { return currentDate.adding(.minute, value: -1) }
    var endDate: Date { return currentDate.adding(.minute, value: 1) }

    // MARK: - timer actions

    func startTimer() {
        guard !isTimerStarted else { return }
        isTimerStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.timeRemain = self.endDate - Date()
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

    private func updateTimeRemainingPersentageIfNeeded() {
        guard timeLeftPersentage < 100 else { return }
        let intervalFromStartToEnd = endDate - startDate
        let newTimeRemaingPersentage = (timeRemain / intervalFromStartToEnd) * 100

        if timeLeftPersentage == 0 {
            timeLeftPersentage = 100 - newTimeRemaingPersentage
        } else if newTimeRemaingPersentage != 0,
                  timeLeftPersentage - newTimeRemaingPersentage >= 1 {
            timeLeftPersentage = 100 - newTimeRemaingPersentage
        }
    }
}
