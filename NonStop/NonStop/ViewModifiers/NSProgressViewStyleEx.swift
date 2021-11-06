//
//  NSProgressStyle + Ex.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

extension ProgressViewStyle {
    func getGradientForFraction(colors: [Color], fractionCompleted: CGFloat) -> AngularGradient {
        return AngularGradient(colors: colors,
                               center: .center,
                               startAngle: Angle(degrees: 0),
                               endAngle: Angle(degrees: 360 * fractionCompleted))
    }

    func getGradientForFraction(gradient: Gradient, fractionCompleted: CGFloat) -> AngularGradient {
        return AngularGradient(gradient: gradient,
                               center: .center,
                               startAngle: Angle(degrees: 0),
                               endAngle: Angle(degrees: 360 * fractionCompleted))
    }
}
