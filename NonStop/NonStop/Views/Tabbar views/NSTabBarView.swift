//
//  NSTabBarView.swift
//  NonStop
//
//  Created by Ilya Maslou on 12.11.21.
//

import SwiftUI

struct NSTabBarView: View {

    // MARK: - variables

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
            .padding(.bottom, SYS.safeAreaBottomInset == 0 ? 0 : SYS.safeAreaBottomInset / 2)
        }
        .frame(width: SYS.screenSize.width,
               height: SYS.tabbarHeight,
               alignment: .bottom)
        .padding(.bottom, SYS.safeAreaBottomInset == 0 ? 16 : SYS.safeAreaBottomInset / 2)
        .backgroundColor(themeColorType: .baseInverted)
    }
}
