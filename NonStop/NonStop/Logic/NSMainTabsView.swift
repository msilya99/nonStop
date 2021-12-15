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
    @State private var shouldShowSheet = false

    // MARK: - init

    init() {
        UITabBar.appearance().isHidden = true
    }

    // MARK: - views

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                TabView(selection: $selectedItem) {
                    NSEventsList()
                        .tag(1)
                    Text("Settings?")
                        .tag(2)
                }

                NSTabBarView(selectedItem: $selectedItem,
                             addItemAction: { shouldShowSheet = true })
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $shouldShowSheet) { NSAddEditEventSheet() }
    }
}
