//
//  NSAddEditEventSheet.swift
//  NonStop
//
//  Created by Ilya Maslou on 25.11.21.
//

import SwiftUI

struct NSAddEditEventSheet: View {

    // MARK: - variables

    @StateObject private var addEditEventModel: NSAddEventViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode

    // MARK: - initialization

    init(eventModel: FetchedResults<Event>.Element? = nil) {
        _addEditEventModel = StateObject(wrappedValue: NSAddEventViewModel(event: eventModel))
    }

    // MARK: - views

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NSAddEditEventSheetFormView(addEditEventModel: addEditEventModel)
                NSPrimaryButton(title: "Save") {
                    guard let model = addEditEventModel.getModel() else { return }
                    addOrEditEvent(model: model)
                }
            }
            .navigationTitle(addEditEventModel.event == nil ? "New event" : "Edit event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
        .accentColor(NSThemeColors.sh.getColorByType(.base))
    }

    //MARK: - saving event to core data

    private func addOrEditEvent(model: NSEventModel) {
        withAnimation {
            var item: Event
            if let event = addEditEventModel.event {
                item = event
            } else {
                item = Event(context: viewContext)
                item.id = UUID()
            }

            item.eventName = model.eventName
            item.fromDate = model.fromDate
            item.toDate = model.toDate
            item.isSpecialDateEvent = model.isSpecialDateEvent
            item.eventDescription = model.eventDescription
            item.color = model.color
            item.selectedIcon = model.selectedIcon

            if viewContext.hasChanges {
                try? viewContext.save()
            }
            dismiss()
        }
    }

    private func dismiss() {
        if presentationMode.wrappedValue.isPresented {
            presentationMode.wrappedValue.dismiss()
        }

        if let topController = UIApplication.shared.windows.first?.rootViewController {
            topController.dismiss(animated: true)
        }
    }
}
