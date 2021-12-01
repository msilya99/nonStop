//
//  NSEventModel.swift
//  NonStop
//
//  Created by Ilya Maslou on 17.11.21.
//

import Foundation
import SwiftUI

struct NSEventModel {
    let eventName: String
    let fromDate: Date?
    let toDate: Date?
    let isSpecialDateEvent: Bool
    let eventDescription: String
    var color: Data?
    let selectedIcon: String

    var eventColor: Color {
        guard let colorDate = color,
              let color = Color.color(withData: colorDate) else {
                  return NSThemeColors.sh.getColorByType(.base)
              }
        return color
    }

    // MARK: - initialisation

    init(eventName: String,
         fromDate: Date?,
         toDate: Date?,
         isSpecialDateEvent: Bool,
         eventDescription: String,
         color: Data?,
         selectedIcon: String) {
        self.eventName = eventName
        self.fromDate = fromDate
        self.toDate = toDate
        self.isSpecialDateEvent = isSpecialDateEvent
        self.eventDescription = eventDescription
        self.color = color
        self.selectedIcon = selectedIcon
    }

    init(event: FetchedResults<Event>.Element) {
        self.eventName = event.eventName ?? ""
        self.fromDate = event.fromDate
        self.toDate = event.toDate
        self.isSpecialDateEvent = event.isSpecialDateEvent
        self.eventDescription = event.eventDescription ?? ""
        self.color = event.color
        self.selectedIcon = event.selectedIcon ?? ""
    }
}
