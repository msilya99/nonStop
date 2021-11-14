//
//  NSViewForegroundModifier.swift
//  NonStop
//
//  Created by Ilya Maslou on 15.11.21.
//

import SwiftUI

struct NSViewForegroundModifier: ViewModifier {

    // MARK: - variables

    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var themeColors: NSThemeColors

    var themeColorType: NSThemeColorType

    // MARK: - view

    func body(content: Content) -> some View {
        content.foregroundColor(getThemeColor())
    }

    // MARK: - get color by theme

    private func getThemeColor() -> Color {
        return themeColors.getColorByType(themeColorType)
    }
}

extension View {
    func foregroundColor(themeColorType: NSThemeColorType) -> some View {
        modifier(NSViewForegroundModifier(themeColorType: themeColorType))
    }
}
