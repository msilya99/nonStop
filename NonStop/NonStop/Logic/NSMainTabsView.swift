//
//  NSMainTabsView.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSMainTabsView: View {

    // MARK: - variables

    @State private var selectedItem = 1
    @State private var shouldShowActionSheet = false

    @Environment(\.colorScheme) var colorScheme
    @StateObject var themeColors = NSThemeColors()

    // MARK: - init

    init() {
        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = UIColor(themeColors.invertedBaseColor)
        UIToolbar.appearance().standardAppearance = appearance
    }

    // MARK: - views

    var body: some View {
        ZStack {
            TabView(selection: $selectedItem) {
                NSAnimationsViewList()
                    .tag(1)
                NSTimerView()
                    .tabItem { Label("Planner", systemImage: "list.bullet.rectangle") }
                    .tag(2)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                NSTabbarButtons(selectedItem: $selectedItem,
                                addItemAction: { self.shouldShowActionSheet = true })
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
