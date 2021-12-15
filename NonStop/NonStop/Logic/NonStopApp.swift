//
//  NonStopApp.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI

@main
struct NonStopApp: App {

    // MARK: - global variables

    let persistenceController = PersistenceController.shared

    // MARK: - app main view

    var body: some Scene {
        WindowGroup {
            NSMainTabsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
