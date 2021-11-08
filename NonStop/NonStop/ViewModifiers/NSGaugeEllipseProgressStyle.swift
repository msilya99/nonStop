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
    var innerStrokeWidth = 7
    var strokeWidth: CGFloat = 9
    var rotation = Angle(degrees: 270)
    var gradientColor = Gradient(colors: [.gray.opacity(0.1), .gray])

    // MARK: - actions

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted: CGFloat = configuration.fractionCompleted ?? 0
        return ZStack {
            Capsule()
                .stroke(strokeColor, lineWidth: strokeWidth)
                .opacity(0.1)
                .rotationEffect(rotation)
                .hidden(!timer.isTimerStarted)

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
