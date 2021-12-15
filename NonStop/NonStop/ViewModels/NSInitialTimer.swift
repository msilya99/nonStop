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

    @Binding var selectedEvent: Event?

    // MARK: - initialization

    init(selectedEvent: Binding<Event?>) {
        _selectedEvent = selectedEvent
        defer {
            updateStartAndEndDate()
        }
    }

    // MARK: - variables

    private var timer = Timer()
    private(set) var isTimerStarted: Bool = false

    private let fullyCompleteValue: Double = 100
    private let currentDate = Date()

    var startDate: Date?
    var endDate: Date?

    // MARK: - timer actions

    func startTimer() {
        guard !isTimerStarted,
              let startDate = self.startDate,
              let endDate = self.endDate else { return }
        isTimerStarted = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            let now = Date()
            guard now > startDate else { return }
            self.timeRemain = endDate - now
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
        guard let startDate = startDate else {
            return ""
        }

        return startDate.toString(format: DateTimeFormat.hoursAndMinutes)
    }

    func getEndDateString() -> String {
        guard let endDate = endDate else {
            return ""
        }

        return endDate.toString(format: DateTimeFormat.hoursAndMinutes)
    }

    func getTimeRemainString() -> String {
        return Date.getIntervalValueString(timeRemain)
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
        guard let startDate = self.startDate,
              let endDate = self.endDate,
              timeLeftPersentage < fullyCompleteValue else { return }
        let intervalFromStartToEnd = endDate - startDate
        let newTimeRemaingPersentage = (timeRemain / intervalFromStartToEnd) * 100
        timeLeftPersentage = newTimeRemaingPersentage == fullyCompleteValue
        ? fullyCompleteValue
        : fullyCompleteValue - newTimeRemaingPersentage
    }

    private func updateStartAndEndDate() {
        guard let event = self.selectedEvent else { return }
        if event.isSpecialDateEvent {
            self.startDate = event.fromDate
            self.endDate = event.toDate
        } else if var fromDate = event.fromDate,
                  var toDate = event.toDate {
            fromDate.onlyTimeDate()
            toDate.onlyTimeDate()

            if fromDate > toDate {
                toDate.day += 1
            }
            self.startDate = fromDate
            self.endDate = toDate
        }
    }
}
