//
//  NSEventsList.swift
//  NonStop
//
//  Created by Ilya Maslou on 21.11.21.
//

import SwiftUI

struct NSEventsList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Event.fromDate, ascending: true)],
        animation: .default)
    private var events: FetchedResults<Event>

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(events) { event in
                        NSEventView(event: NSEventModel(event: event))
                    }
                }
            }
            .navigationBarTitle(Text("Events"))
        }
    }
}
