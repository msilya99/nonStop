//
//  NSAddEventSheet.swift
//  NonStop
//
//  Created by Ilya Maslou on 14.11.21.
//

import SwiftUI

struct NSAddEditEventSheet: View {

    // MARK: - variables

    @StateObject private var addEditEventModel = NSAddEventViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @Binding var shouldBeVisible: Bool

    // MARK: - initialization

    init(shouldBeVisible: Binding<Bool>, eventModel: NSEventModel? = nil) {
        _shouldBeVisible = shouldBeVisible
        guard let eventModel = eventModel else { return }
        self.addEditEventModel.setModel(eventModel)
    }

    // MARK: - views

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NSAddEditEventSheetFormView(addEditEventModel: addEditEventModel)
                NSPrimaryButton(title: "Save") {
                    guard let model = addEditEventModel.getModel() else { return }
                    addEvent(model: model)
                }
            }
            .navigationTitle(addEditEventModel.isEditing ? "Edit event" : "New event")
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
