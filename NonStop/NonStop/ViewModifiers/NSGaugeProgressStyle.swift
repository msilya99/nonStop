//
//  NSGaugeProgressStyle.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSGaugeProgressStyle: ProgressViewStyle {

    // MARK: - variables

    @ObservedObject var timer: NSInitialTimer

    var foregroundColor = Color.red
    var gradientColor = Gradient(colors: [.red, .pink])
    var strokeWidth = 20.0
    var rotation: Angle = Angle(degrees: 270)

    // MARK: - actions

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        ZStack {
            if timer.isTimerStarted {
                Circle()
                    .stroke(lineWidth: self.strokeWidth)
                    .opacity(0.3)
                    .foregroundColor(self.foregroundColor)
            }

            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(getGradientForFractional(fractionCompleted: fractionCompleted),
                        style: StrokeStyle(lineWidth:
                                            CGFloat(strokeWidth),
                                           lineCap: .round,
                                           lineJoin: .round))
                .rotationEffect(rotation)
                .animation(.easeInOut)
        }
    }

    func getGradientForFractional(fractionCompleted: Double) -> AngularGradient {
        return AngularGradient(gradient: gradientColor,
                               center: .center,
                               startAngle: Angle(degrees: 0),
                               endAngle: Angle(degrees: 360 * fractionCompleted))
    }
}
