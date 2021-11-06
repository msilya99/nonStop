//
//  NSGaugeEllipseProgressStyle.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSGaugeEllipseProgressStyle: ProgressViewStyle {

    // MARK: - variables

    @ObservedObject var timer: NSInitialTimer

    var strokeColor = Color.gray
    var innerStrokeWidth = 5
    var strokeWidth: CGFloat = 7
    var rotation = Angle(degrees: 270)
    var gradientColor = Gradient(colors: [.gray.opacity(0.1), .gray])

    // MARK: - actions

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted: CGFloat = configuration.fractionCompleted ?? 0
        return ZStack {
            if timer.isTimerStarted {
                Capsule()
                    .stroke(strokeColor, lineWidth: strokeWidth)
                    .opacity(0.1)
                    .rotationEffect(rotation)
            }

            Capsule()
                .trim(from: 0, to: fractionCompleted)
                .stroke(getGradientForFraction(gradient: gradientColor, fractionCompleted: fractionCompleted),
                        style: StrokeStyle(lineWidth: strokeWidth,
                                           lineCap: .round))
                .rotationEffect(rotation)
                .animation(.easeInOut, value: fractionCompleted)
        }
    }
}
