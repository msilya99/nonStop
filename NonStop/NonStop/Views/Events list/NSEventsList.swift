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

    // MARK: - body views

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(events) { event in
                        NSEventView(event: NSEventModel(event: event),
                                    editEventAction: { print("Event editing") },
                                    deleteEventAction: { [weak event] in
                            deleteEvent(event) })
                    }
                }
                .padding(.bottom, SYS.tabbarHeight)
            }
            .navigationBarTitle(Text("Events"))
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
}
