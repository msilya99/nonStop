//
//  NSTabBarButton.swift
//  NonStop
//
//  Created by Ilya Maslou on 11.11.21.
//

import SwiftUI

struct NSTabBarButton: View {

    // MARK: - variables

    var title: String
    var imageName: String
    var action: () -> Void

    // MARK: - view

    var body: some View {
        Button {
            action()
        } label: {
            VStack(alignment: .center, spacing: 0) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: SYS.screenSize.width / 14,
                           height: SYS.screenSize.width / 14)
                Text(title)
            }
            .padding(.top, 8)
            .foregroundColor(themeColorType: .base)
        }
    }
}
