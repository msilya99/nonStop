//
//  NSColors.swift
//  NonStop
//
//  Created by Ilya Maslou on 11.11.21.
//

import SwiftUI

enum NSThemeColorType {
    case base
    case baseInverted
}

class NSThemeColors: ObservableObject {

    // MARK: - variables

    private var isDarkTheme: Bool {
        return SYS.appTheme == .dark
    }

    // MARK: - colors

    private var baseColor: Color {
        return isDarkTheme ? .white : .black
    }

    private var invertedBaseColor: Color {
        return isDarkTheme ? .black : .white
    }

    func getColorByType(_ type: NSThemeColorType) -> Color {
        switch type {
        case .base:
            return baseColor
        case .baseInverted:
            return invertedBaseColor
        }
    }
}
