//
//  NSAnimationsViewList.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSAnimationsViewList: View {

    // MARK: - variables

    @EnvironmentObject var initialTimer: NSInitialTimer

    // MARK: - views

    var body: some View {
        NavigationView {
            List {
                Section() {
                    NavigationLink(destination: NSTimerView()) {
                        Text("StandartCircleAnimation")
                    }
                    NavigationLink(destination: NSFancyLoaderView()) {
                        Text("StandartFancyCircleAnimation")
                    }
                    NavigationLink(destination: NSWatterCircleAnimationProgressView(initialTimer: initialTimer)) {
                        Text("WatterCircleAnimation")
                    }
                    NavigationLink(destination: NSDotStyleProgressView(initialTimer: initialTimer)) {
                        Text("DotStyleProgress")
                    }
                }
            }
            .navigationTitle("Animations")
            .listStyle(InsetGroupedListStyle())
        }
    }
}
