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

    @State private var selectedEvent: Event? {
        didSet {
            if selectedEvent != nil {
                viewUpdater.stopTimer()
            } else {
                viewUpdater.startTimer()
            }
        }
    }
    
    @StateObject private var viewUpdater = NSUpdaterViewModel()

    // MARK: - body views

    var body: some View {
        ScrollView(showsIndicators: false) {
            if selectedEvent != nil {
                NSTimerView(selectedEvent: $selectedEvent)
            }
            LazyVStack(spacing: 16) {
                getEventsBlock(isCurrentEvents: true)
                getEventsBlock(isCurrentEvents: false)
            }
            .padding(.bottom, SYS.tabbarHeight)
        }
        .navigationBarTitle(Text("\(selectedEvent != nil ? selectedEvent?.eventName ?? "" : "Events")"))
        .onAppear {
            guard selectedEvent == nil else { return }
            selectedEvent = getFilteredEvents(shouldBeCurrent: true).first
        }
    }

    // MARK: - create event

    @ViewBuilder
    private func getEventView(event: Event) -> some View {
        let currentEventsContainEvent = getFilteredEvents(shouldBeCurrent: true).contains(event)
        let eventModel = NSEventModel(event: event)
        ZStack(alignment: .topLeading) {
            NSEventView(event: eventModel,
                        editEventAction: { [weak event] in
                selectedEventForEditing = event
            },
                        deleteEventAction: { [weak event] in
                deleteEvent(event)
            })
                .sheet(item: $selectedEventForEditing) { eventItem in
                    NSAddEditEventSheet(eventModel: eventItem)
                }
                .onTapGesture {
                    guard currentEventsContainEvent else { return }
                    withAnimation(.linear) {
                        selectedEvent = selectedEvent == event ? nil : event
                    }
                }

                NSChipEventView(title: "Current", eventColor: eventModel.eventColor)
                    .offset(y: -10)
                    .offset(x: 20)
                    .hidden(!(currentEventsContainEvent && selectedEvent == event))
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

            if selectedEvent == event {
                selectedEvent = nil
            }
        }
    }

    // MARK: - getters

    private func getFilteredEvents(shouldBeCurrent: Bool) -> [Event] {
        return events.filter { event in
            guard let toDate = event.toDate,
                  let fromDate = event.fromDate else { return false }
            var isCurrentEvent: Bool = false
            if event.isSpecialDateEvent {
                isCurrentEvent = fromDate...toDate ~= Date.getCurrentDate()
            } else if fromDate > toDate || !event.isSpecialDateEvent {
                isCurrentEvent = Date
                    .getCurrentDate()
                    .isInTimeInterval(fromDate: fromDate.getTimeZoneDate(),
                                      toDate: toDate.getTimeZoneDate())
            }

            return shouldBeCurrent ? isCurrentEvent : !isCurrentEvent
        }
    }
}
