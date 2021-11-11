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

    // MARK: - init

    init() {
        UITabBar.appearance().isHidden = true
    }

    // MARK: - views

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedItem) {
                NSAnimationsViewList()
                    .tag(1)
                NSTimerView()
                    .tag(2)
            }

            NSTabBarView(selectedItem: $selectedItem,
                         addItemAction: { self.shouldShowActionSheet = true })
        }
        .edgesIgnoringSafeArea(.bottom)
        .actionSheet(isPresented: $shouldShowActionSheet) {
            ActionSheet(title: Text("Title"),
                        message: Text("Message"),
                        buttons: [
                            .cancel { shouldShowActionSheet.toggle() }
                        ])
        }
    }
}
