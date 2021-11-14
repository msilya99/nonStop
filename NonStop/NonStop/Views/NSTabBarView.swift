//
//  NSTabBarView.swift
//  NonStop
//
//  Created by Ilya Maslou on 12.11.21.
//

import SwiftUI

struct NSTabBarView: View {

    // MARK: - variables

    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.colorScheme) var colorScheme
    @StateObject var themeColors = NSThemeColors()

    @Binding var selectedItem: Int
    var addItemAction: () -> Void

    // MARK: - view

    var body: some View {
        Group{
            Spacer()
            HStack(alignment: .bottom, spacing: SYS.screenSize.width / 10) {
                Spacer()

                NSTabBarButton(title: "Now",
                               imageName: "clock") {
                    selectedItem = 1
                }.opacity(selectedItem == 1 ? 1 : 0.3)

                NSAddItemTabButon { addItemAction() }

                NSTabBarButton(title: "Planner",
                               imageName: "list.bullet.rectangle") {
                    selectedItem = 2
                }.opacity(selectedItem == 2 ? 1 : 0.3)

                Spacer()
            }
            .padding(.bottom, safeAreaInsets.bottom == 0 ? 0 : safeAreaInsets.bottom / 2)
        }
        .frame(width: .infinity,
               height: SYS.screenSize.height / 10,
               alignment: .bottom)
        .padding(.bottom, safeAreaInsets.bottom == 0 ? 16 : safeAreaInsets.bottom / 2)
        .background(themeColors.invertedBaseColor)
    }
}
