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

    // MARK: - global variables

    let persistenceController = PersistenceController.shared
    @StateObject var initialTimer = NSInitialTimer()
    @StateObject var themeColors = NSThemeColors()

    @Environment(\.colorScheme) var colorScheme

    // MARK: - app main view

    var body: some Scene {
        WindowGroup {
            NSMainTabsView()
                .environmentObject(initialTimer)
                .environmentObject(themeColors)
        }
    }
}
