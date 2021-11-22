//
//  NSBaseColors.swift
//  NonStop
//
//  Created by Ilya Maslou on 23.11.21.
//

import SwiftUI

enum NSBaseColorType {
    case baseDark
    case baseLight
    case base02Dark
    case base02Light
}

class NSBaseColors {

    static let sh = NSBaseColors()

    // MARK: - colors

    private var baseDark = Color.white
    private var baseLight = Color.black
    private var base02Dark = Color.white.opacity(0.7)
    private var base02Light = Color.gray

    func getColorByType(_ type: NSBaseColorType) -> Color {
        switch type {
        case .baseDark:
            return baseDark
        case .baseLight:
            return baseLight
        case .base02Dark:
            return base02Dark
        case .base02Light:
            return base02Light
        }
    }

    func getColor(_ type: NSThemeColorType, isLightColor: Bool) -> Color {
        switch type {
        case .base:
            return isLightColor
            ? getColorByType(.baseLight)
            : getColorByType(.baseDark)
        case .base02:
            return isLightColor
            ? getColorByType(.base02Light)
            : getColorByType(.base02Dark)
        case .baseInverted:
            return isLightColor
            ? getColorByType(.baseDark)
            : getColorByType(.baseLight)
        case .base02Inverted:
            return isLightColor
            ? getColorByType(.base02Dark)
            : getColorByType(.base02Light)
        case .unknown:
            return .clear
        }
    }

    private init() { }
}
