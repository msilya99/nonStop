//
//  NSAddEventSheet.swift
//  NonStop
//
//  Created by Ilya Maslou on 14.11.21.
//

import SwiftUI

struct NSAddEventSheet: View {

    // MARK: - variables

    @StateObject private var addEventModel = NSAddEventViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @Binding var shouldBeVisible: Bool

    // MARK: - views

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NSAddEventSheetFormView(addEventModel: addEventModel)
                NSPrimaryButton(title: "Save and add") {
                    guard let model = addEventModel.getModel() else { return }
                    addEvent(model: model)
                }
            }
            .navigationTitle("New event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        shouldBeVisible = false
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
        .accentColor(NSThemeColors.sh.getColorByType(.base))
    }

    //MARK: - saving event to core data

    private func addEvent(model: NSEventModel) {
        withAnimation {
            let newItem = Event(context: viewContext)
            newItem.eventName = model.eventName
            newItem.fromDate = model.fromDate
            newItem.toDate = model.toDate
            newItem.isSpecialDateEvent = model.isSpecialDateEvent
            newItem.eventDescription = model.eventDescription
            newItem.color = model.color
            newItem.selectedIcon = model.selectedIcon
            newItem.id = UUID()

            if viewContext.hasChanges {
                try? viewContext.save()
            }
            shouldBeVisible = false
        }
    }
}
