//
//  NSColors.swift
//  NonStop
//
//  Created by Ilya Maslou on 11.11.21.
//

import SwiftUI

enum NSThemeColorType {
    case base
    case base02
    case baseInverted
    case base02Inverted
    case unknown
}

class NSThemeColors {

    static let sh = NSThemeColors()

    // MARK: - colors

    private var baseColor = Color(light: .black, dark: .white)
    private var invertedBaseColor = Color(light: .white, dark: .black)
    private var base02 = Color(light: .gray, dark: .white.opacity(0.7))
    private var base02Inverted = Color(light:  .white.opacity(0.7), dark: .gray)

    func getColorByType(_ type: NSThemeColorType) -> Color {
        switch type {
        case .base:
            return baseColor
        case .baseInverted:
            return invertedBaseColor
        case .base02:
            return base02
        case .base02Inverted:
            return base02Inverted
        case .unknown:
            return .clear
        }
    }

    func getTypeByColor(_ color: Color) -> NSThemeColorType {
        switch color {
        case baseColor:
            return .base
        case invertedBaseColor:
            return .baseInverted
        case base02:
            return .base02
        case base02Inverted:
            return .base02Inverted
        default:
            return .unknown
        }
    }

    private init() { }
}
