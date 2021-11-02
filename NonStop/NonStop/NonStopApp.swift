//
//  NonStopApp.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI

@main
struct NonStopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
