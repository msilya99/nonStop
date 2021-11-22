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
            ScrollView {
                LazyVStack(spacing: 16) {
//            List {
                    ForEach(events) { event in
                        NSEventView(event: NSEventModel(event: event))
                    }
//                    .onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle(Text("Events"))
        }
    }

    // MARK: - actions

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { events[$0] }.forEach(viewContext.delete)
            if viewContext.hasChanges {
                try? viewContext.save()
            }
        }
    }
}
