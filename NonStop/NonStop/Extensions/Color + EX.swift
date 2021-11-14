//
//  Color + EX.swift
//  NonStop
//
//  Created by Ilya Maslou on 15.11.21.
//

import SwiftUI
import UIKit

extension UIColor {
    convenience init(light lightModeColor: @escaping @autoclosure () -> UIColor,
                     dark darkModeColor: @escaping @autoclosure () -> UIColor) {
        self.init {
            traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light:
                return lightModeColor()
            case .dark:
                return darkModeColor()
            default:
                return lightModeColor()
            }
        }
    }
}

extension Color {
    init(light lightModeColor: @escaping @autoclosure () -> Color,
         dark darkModeColor: @escaping @autoclosure () -> Color) {
        self.init(UIColor(light: UIColor(lightModeColor()), dark: UIColor(darkModeColor()) ))
    }
}


