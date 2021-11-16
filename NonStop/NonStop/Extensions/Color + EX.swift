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

    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

extension Color {
    init(light lightModeColor: @escaping @autoclosure () -> Color,
         dark darkModeColor: @escaping @autoclosure () -> Color) {
        self.init(UIColor(light: UIColor(lightModeColor()), dark: UIColor(darkModeColor()) ))
    }

    func encode() -> Data? {
        let object = UIColor(self)
        return try? NSKeyedArchiver.archivedData(withRootObject: object,
                                                 requiringSecureCoding: true)
    }

    func color(withData data: Data) -> Color? {
        guard let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) else { return nil}
        let colorComponents = uiColor.rgba
        return Color(.sRGBLinear,
                     red: colorComponents.red,
                     green: colorComponents.green,
                     blue: colorComponents.blue,
                     opacity: colorComponents.alpha)
    }
}


