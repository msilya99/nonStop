//
//  NSAddEventSheetFormView.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.11.21.
//

import SwiftUI

struct NSAddEditEventSheetFormView: View {

    // MARK: - variables

    @ObservedObject var addEditEventModel: NSAddEventViewModel

    // MARK: - views

    var body: some View {
        Form {
            Section {
                TextField("Enter event name", text: $addEditEventModel.eventName)
                    .alert(isPresented: $addEditEventModel.showEventAlert) {
                        Alert(title: Text("Saving error!"),
                              message: Text("You forget to give a name to event"),
                              dismissButton: .default(Text("OK")) { addEditEventModel.showEventAlert = false })
                    }
                Toggle("\(addEditEventModel.isEverydayEvent ? "Everyday event" : "Special date event" )",
                       isOn: $addEditEventModel.isEverydayEvent)
                DatePicker("Starts",
                           selection: $addEditEventModel.fromDate,
                           in: getFromDate()...,
                           displayedComponents: getDatePickerComponents())

                DatePicker("Ends",
                           selection: $addEditEventModel.toDate,
                           in: getToDateRange(),
                           displayedComponents: getDatePickerComponents())
            }

            Section(header: Text("You can add description to event")) {
                Toggle("Add description?",
                       isOn: $addEditEventModel.isNeedDescription.animation())

                if addEditEventModel.isNeedDescription {
                    NSTextEditor(text: $addEditEventModel.eventDescription)
                        .frame(maxHeight: 150)
                }
            }

            Section(header: Text("Customization")) {
                ColorPicker("Select color", selection: $addEditEventModel.eventColor, supportsOpacity: false)
                getEmojiPickerView()
            }
        }
        .environment(\.locale, Locale.init(identifier: SYS.langCode.rawValue))
    }

    @ViewBuilder
    private func getEmojiPickerView() -> some View {
        HStack {
            Text("Select icon")
            Spacer()
            Text("\(addEditEventModel.selectedIcon)").font(.title)
        }.background(NavigationLink("", destination: NSEmojiPicker(selectedEmoji: $addEditEventModel.selectedIcon)).opacity(0))
    }

    // MARK: - actions

    private func getDatePickerComponents() -> DatePickerComponents {
        return addEditEventModel.isEverydayEvent
        ? .hourAndMinute
        : [.date, .hourAndMinute]
    }

    // TODO: - refactor this
    private func getFromDate() -> Date {
        if addEditEventModel.isEverydayEvent {
            return Date.getCurrentDate().startDay()
        } else {
            return addEditEventModel.fromDate.startDay() != Date.getCurrentDate().startDay() ?  addEditEventModel.fromDate.startDay() : addEditEventModel.fromDate
        }
    }

    private func getToDateRange() -> ClosedRange<Date> {
        return getFromDate().adding(.minute, value: 5)...addEditEventModel.fromDate.adding(.day, value: 1).adding(.minute, value: 5)
    }
}
