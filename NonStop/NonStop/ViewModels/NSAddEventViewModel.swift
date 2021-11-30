//
//  NSAddEventViewModel.swift
//  NonStop
//
//  Created by Ilya Maslou on 17.11.21.
//

import Foundation
import SwiftUI

class NSAddEventViewModel: ObservableObject {

    // MARK: - variables

    @Published var eventName: String = ""
    
    @Published var isEverydayEvent = true {
        didSet {
            updateDateIfNeeded()
        }
    }

    @Published var fromDate: Date = Date.getCurrentDate() {
        didSet {
            guard !isEverydayEvent,
                  fromDate.adding(.minute, value: 5) >= toDate else { return }
            toDate = fromDate.adding(.minute, value: 5)
        }
    }
    
    @Published var toDate: Date = Date.getCurrentDate().adding(.minute, value: 5)
    @Published var isNeedDescription = false
    @Published var eventDescription: String = ""
    @Published var eventColor = NSThemeColors.sh.getColorByType(.base)
    @Published var selectedIcon = "🤝"
    @Published var showNameAlert: Bool = false
    @Published var showDateAlert: Bool = false
    var event: Event?

    // MARK: - initialisation

    init(event: Event? = nil) {
        setModelIfNeeded(event)
    }

    // MARK: - getter

    func getModel() -> NSEventModel? {
        guard !eventName.isEmpty else {
            showNameAlert = true
            return nil
        }

        guard isRangeGreaterThenTo(minutes: 4) else {
            showDateAlert = true
            return nil
        }

        return NSEventModel(eventName: eventName,
                            fromDate: fromDate,
                            toDate: toDate,
                            isSpecialDateEvent: !isEverydayEvent,
                            eventDescription: eventDescription,
                            color: eventColor.encode(),
                            selectedIcon: selectedIcon)
    }

    // MARK: - setter

    private func setModelIfNeeded(_ event: FetchedResults<Event>.Element?) {
        guard let event = event else { return }
        self.event = event
        eventName = event.eventName ?? ""
        isEverydayEvent = !event.isSpecialDateEvent
        if let fromDate = event.fromDate {
            self.fromDate = fromDate
        }

        if let toDate = event.toDate {
            self.toDate = toDate
        }

        isNeedDescription = !(event.eventDescription?.isEmpty ?? true)
        eventDescription = event.eventDescription ?? ""
        if let colorData = event.color,
           let color = Color.color(withData: colorData) {
            eventColor = color
        }

        selectedIcon = event.selectedIcon ?? "🤝"
    }

    private func updateDateIfNeeded() {
        if isEverydayEvent {
            fromDate = Date.getCurrentDate()
            toDate = Date.getCurrentDate().adding(.minute, value: 5)
        } else {
            fromDate = fromDate.startDay() != Date.getCurrentDate().startDay() ? fromDate : Date.getCurrentDate()
        }
    }

    private func isRangeGreaterThenTo(days: Int = 0, hours: Int = 0, minutes: Int = 0) -> Bool {
        let date = Date(timeIntervalSinceReferenceDate: toDate - fromDate)
        if (date.day - 1) > days || date.hour > hours || date.minute > minutes {
            return true
        }
        return false
    }

}
