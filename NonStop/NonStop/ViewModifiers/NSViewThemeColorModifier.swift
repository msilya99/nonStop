//
//  NSViewForegroundModifier.swift
//  NonStop
//
//  Created by Ilya Maslou on 15.11.21.
//

import SwiftUI

enum NSViewThemeType {
    case background
    case foreground
}

struct NSViewThemeColorModifier: ViewModifier {

    // MARK: - variables

    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var themeColors: NSThemeColors

    var type: NSViewThemeType
    var themeColor: Color?
    var themeColorType: NSThemeColorType?

    // MARK: - view

    func body(content: Content) -> some View {
        switch type {
        case .background:
            getBackgroundThemeView(content: content)
        case .foreground:
            getForegroundThemeView(content: content)
        }
    }

    // MARK: - get color by theme

    private func getThemeColor(colorType: NSThemeColorType) -> Color {
        return themeColors.getColorByType(colorType)
    }

    @ViewBuilder private func getBackgroundThemeView(content: Content) -> some View {
        if let themeColor = themeColor {
            content.background(themeColor)
        } else if let themeColorType = themeColorType {
            content.background(getThemeColor(colorType: themeColorType))
        } else {
            content
        }
    }

    @ViewBuilder private func getForegroundThemeView(content: Content) -> some View {
        if let themeColor = themeColor {
            content.foregroundColor(themeColor)
        } else if let themeColorType = themeColorType {
            content.foregroundColor(getThemeColor(colorType: themeColorType))
        } else {
            content
        }
    }
}

extension View {
    func foregroundColor(themeColor: Color? = nil, themeColorType: NSThemeColorType? = nil) -> some View {
        modifier(NSViewThemeColorModifier(type: .foreground,
                                          themeColor: themeColor,
                                          themeColorType: themeColorType))
    }

    func backgroundColor(themeColor: Color? = nil, themeColorType: NSThemeColorType? = nil) -> some View {
        modifier(NSViewThemeColorModifier(type: .background,
                                          themeColor: themeColor,
                                          themeColorType: themeColorType))
    }
}
