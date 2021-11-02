//
//  NonStopApp.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI
import UIKit

@main
struct NonStopApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var initialTimerDate = NSInitialTimer()

    var body: some Scene {
        WindowGroup {
//            CoreDataExample()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            NSTimerView()
                .environmentObject(initialTimerDate)
        }
    }
}
