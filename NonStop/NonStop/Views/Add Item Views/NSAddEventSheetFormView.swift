//
//  NSAddEventSheetFormView.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.11.21.
//

import SwiftUI

struct NSAddEventSheetFormView: View {

    // MARK: - variables

    @State private var eventName: String = ""
    @State private var isSpecialDayEvent = false
    @State private var fromDate: Date = Date().adding(.day, value: 1)
    @State private var toDate: Date = Date().adding(.day, value: 1).adding(.hour, value: 1)
    @State private var eventDescription: String = ""
    @State private var eventColor = Color.pink

    // MARK: - views

    var body: some View {
        Form {
            Section {
                TextField("Enter event name", text: $eventName)
                Toggle("\(isSpecialDayEvent ? "Special date event" : "Everyday event")",
                       isOn: $isSpecialDayEvent)
                DatePicker("Starts",
                           selection: $fromDate,
                           in: Date()...,
                           displayedComponents: getDatePickerComponents())

                DatePicker("Ends",
                           selection: $toDate,
                           in: fromDate.adding(.minute, value: 5)...,
                           displayedComponents: getDatePickerComponents())
            }

            Section(header: Text("You can add description to event")) {
                TextEditor(text: $eventDescription)
                    .frame(maxHeight: 150)
            }

            Section(header: Text("Customization")) {
                ColorPicker("Select color", selection: $eventColor, supportsOpacity: false)
            }
        }
    }

    private func getDatePickerComponents() -> DatePickerComponents {
        return isSpecialDayEvent ? [.date, .hourAndMinute] : .hourAndMinute
    }
}
