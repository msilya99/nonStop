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
    @Published var isSpecialDateEvent = false
    @Published var fromDate: Date = Date().adding(.day, value: 1)
    @Published var toDate: Date = Date().adding(.day, value: 1).adding(.hour, value: 1)
    @Published var isNeedDescription = false
    @Published var eventDescription: String = ""
    @Published var eventColor = Color.pink
    @Published var selectedIcon = "🤝"
    @Published var showEventAlert: Bool = false

    // MARK: - actions

    func getModel() -> NSEventModel? {
        guard !eventName.isEmpty else {
            showEventAlert = true
            return nil
        }

        return NSEventModel(name: eventName,
                            fromDate: fromDate,
                            toDate: toDate,
                            isSpecialDateEvent: isSpecialDateEvent,
                            eventDescription: eventDescription,
                            color: eventColor.encode(),
                            selectedIcon: selectedIcon)
    }
}
