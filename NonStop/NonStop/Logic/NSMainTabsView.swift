//
//  NSMainTabsView.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSMainTabsView: View {

    // MARK: - variables

    @Environment(\.colorScheme) var colorScheme

    @State private var selectedItem = 1
    @State private var shouldShowActionSheet = false

    // MARK: - views

    var body: some View {
        ZStack {
            TabView(selection: $selectedItem) {
                NSAnimationsViewList()
                    .tabItem {
                        Label("Now",
                              systemImage: "clock")
                    }
                    .tag(1)
                NSTimerView()
                    .tabItem {
                        Label("Planner",
                              systemImage: "list.bullet.rectangle")
                    }
                    .tag(2)
            }
        }
        .actionSheet(isPresented: $shouldShowActionSheet) {
            ActionSheet(title: Text("Title"),
                        message: Text("Message"),
                        buttons: [
                            .cancel { shouldShowActionSheet.toggle() }
                        ])
        }
    }
}
