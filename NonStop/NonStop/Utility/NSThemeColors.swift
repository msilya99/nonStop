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

class NSThemeColors {

    static let sh = NSThemeColors()

    // MARK: - colors

    private var baseColor = Color(light: .black, dark: .white)
    private var invertedBaseColor = Color(light: .white, dark: .black)

    func getColorByType(_ type: NSThemeColorType) -> Color {
        switch type {
        case .base:
            return baseColor
        case .baseInverted:
            return invertedBaseColor
        }
    }

    private init() { }
}
