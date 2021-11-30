//
//  NSEventsList.swift
//  NonStop
//
//  Created by Ilya Maslou on 21.11.21.
//

import SwiftUI

struct NSEventsList: View {

    // MARK: - variables
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.fromDate, ascending: true)],
        animation: .default)
    private var events: FetchedResults<Event>

    @State private var selectedEventForEditing: Event?

    // MARK: - body views

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    getEventsBlock(isCurrentEvents: true)
                    getEventsBlock(isCurrentEvents: false)
                }
                .padding(.bottom, SYS.tabbarHeight)
            }
            .navigationBarTitle(Text("Events"))
        }
    }

    // MARK: - create event

    @ViewBuilder
    private func getEventView(event: Event) -> some View {
        NSEventView(event: NSEventModel(event: event),
                    editEventAction: { [weak event] in
            selectedEventForEditing = event
        },
                    deleteEventAction: { [weak event] in
            deleteEvent(event)
        })
            .sheet(item: $selectedEventForEditing) { eventItem in
                NSAddEditEventSheet(eventModel: eventItem)
            }
    }

    // MARK: - create events block

    @ViewBuilder
    private func getEventsBlock(isCurrentEvents: Bool) -> some View {
        let filteredEvents = getFilteredEvents(shouldBeCurrent: isCurrentEvents)
        if !filteredEvents.isEmpty {
            VStack(alignment: .leading, spacing: 16) {
                Text(isCurrentEvents ? "Current events" : "Not current events for today")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(NSThemeColors.sh.getColorByType(.base))
                ForEach(filteredEvents) { event in
                    getEventView(event: event)
                }
            }.padding(16)
        }
    }

    // MARK: - delete event action

    private func deleteEvent(_ event: FetchedResults<Event>.Element?) {
        guard let event = event else { return }
        withAnimation(.linear) {
            viewContext.delete(event)
            if viewContext.hasChanges {
                try? viewContext.save()
            }
        }
    }

    // MARK: - getters

    private func getFilteredEvents(shouldBeCurrent: Bool) -> [Event] {
        return events.filter { event in

            // TODO: - refactor this
            guard let toDate = event.toDate,
                  let fromDate = event.fromDate else { return false }
            var isCurrentEvent: Bool = false
            if event.isSpecialDateEvent {
                isCurrentEvent = fromDate...toDate ~= Date.getCurrentDate()
            } else if fromDate > toDate {
                var toDateWithAdditionalInterval = toDate
                toDateWithAdditionalInterval.addTimeInterval(fromDate - toDate)
                isCurrentEvent = fromDate...toDateWithAdditionalInterval ~= Date.getCurrentDate()
            }

            return shouldBeCurrent ? isCurrentEvent : !isCurrentEvent
        }
    }
}
