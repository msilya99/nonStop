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
            self.updateDatesBySwitch()
        }
    }

    @Published var fromDate: Date = Date() {
        didSet {
            guard fromDate.adding(.minute, value: 5) >= toDate else { return }
            toDate = fromDate.adding(.minute, value: 5)
        }
    }
    @Published var toDate: Date = Date().adding(.minute, value: 5)
    @Published var isNeedDescription = false
    @Published var eventDescription: String = ""
    @Published var eventColor = NSThemeColors.sh.getColorByType(.base)
    @Published var selectedIcon = "🤝"
    @Published var showEventAlert: Bool = false
    var event: Event?

    // MARK: - initialisation

    init(event: Event? = nil) {
        setModelIfNeeded(event)
    }

    // MARK: - getter

    func getModel() -> NSEventModel? {
        guard !eventName.isEmpty else {
            showEventAlert = true
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

    private func updateDatesBySwitch() {
        toDate = isEverydayEvent
        ? toDate.adding(.day, value: 1)
        : toDate.adding(.day, value: -1)

        fromDate = isEverydayEvent
        ? fromDate.adding(.day, value: 1)
        : fromDate.adding(.day, value: -1)
    }
}
