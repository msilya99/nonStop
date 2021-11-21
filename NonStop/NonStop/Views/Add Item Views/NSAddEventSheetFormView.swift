//
//  NSAddEventSheetFormView.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.11.21.
//

import SwiftUI

struct NSAddEventSheetFormView: View {

    // MARK: - variables

    @ObservedObject var addEventModel: NSAddEventViewModel

    // MARK: - views

    var body: some View {
        Form {
            Section {
                TextField("Enter event name", text: $addEventModel.eventName)
                    .alert(isPresented: $addEventModel.showEventAlert) {
                        Alert(title: Text("Saving error!"),
                              message: Text("You forget to give a name to event"),
                              dismissButton: .default(Text("OK")) { addEventModel.showEventAlert = false })
                    }
                Toggle("\(addEventModel.isSpecialDateEvent ? "Special date event" : "Everyday event")",
                       isOn: $addEventModel.isSpecialDateEvent)
                DatePicker("Starts",
                           selection: $addEventModel.fromDate,
                           in: Date()...,
                           displayedComponents: getDatePickerComponents())

                DatePicker("Ends",
                           selection: $addEventModel.toDate,
                           in: addEventModel.fromDate.adding(.minute, value: 5)...addEventModel.fromDate.adding(.day, value: 1),
                           displayedComponents: getDatePickerComponents())
            }

            Section(header: Text("You can add description to event")) {
                Toggle("Add description?",
                       isOn: $addEventModel.isNeedDescription.animation())

                if addEventModel.isNeedDescription {
                    NSTextEditor(text: $addEventModel.eventDescription)
                        .frame(maxHeight: 150)
                }
            }

            Section(header: Text("Customization")) {
                ColorPicker("Select color", selection: $addEventModel.eventColor, supportsOpacity: false)
                getEmojiPickerView()
            }
        }
        .environment(\.locale, Locale.init(identifier: SYS.langCode.rawValue))
    }

    @ViewBuilder private func getEmojiPickerView() -> some View {
        HStack {
            Text("Select icon")
            Spacer()
            Text("\(addEventModel.selectedIcon)").font(.title)
        }.background(NavigationLink("", destination: NSEmojiPicker(selectedEmoji: $addEventModel.selectedIcon)).opacity(0))
    }

    // MARK: - actions

    private func getDatePickerComponents() -> DatePickerComponents {
        return addEventModel.isSpecialDateEvent ? [.date, .hourAndMinute] : .hourAndMinute
    }
}
