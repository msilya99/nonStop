//
//  NSTabbarButtons.swift
//  NonStop
//
//  Created by Ilya Maslou on 11.11.21.
//

import SwiftUI

struct NSTabbarButtons: View {

    // MARK: - variables

    @Binding var selectedItem: Int
    var addItemAction: () -> Void

    // MARK: - view

    var body: some View {
        Group {
            Spacer()
            NSTabBarButton(title: "Now",
                           imageName: "clock") {
                selectedItem = 1
            }.opacity(selectedItem == 1 ? 1 : 0.3)

            Spacer()
            NSAddItemTabButon { addItemAction() }
            Spacer()

            NSTabBarButton(title: "Planner",
                           imageName: "list.bullet.rectangle") {
                selectedItem = 2
            }.opacity(selectedItem == 2 ? 1 : 0.3)
            Spacer()
        }
    }
}
