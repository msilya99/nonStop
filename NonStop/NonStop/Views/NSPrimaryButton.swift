//
//  NSPrimaryButton.swift
//  NonStop
//
//  Created by Ilya Maslou on 15.11.21.
//

import SwiftUI

struct NSPrimaryButton: View {

    // MARK: - variables

    var title: String
    var action: () -> Void
    var horizontalPadding: CGFloat = 32

    // MARk: - views

    var body: some View {
        Button(title) { action() }
        .frame(maxWidth: .infinity)
        .font(.title3)
        .padding()
        .backgroundColor(themeColorType: .base)
        .clipShape(Capsule())
        .padding(.horizontal, horizontalPadding)
        .foregroundColor(themeColorType: .baseInverted)
    }
}
