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
    var strokeWidth: CGFloat = 25
    var rotation: Angle = Angle(degrees: 270)

    // MARK: - actions

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted: CGFloat = configuration.fractionCompleted ?? 0
        ZStack {
            Circle()
                .stroke(foregroundColor, lineWidth: strokeWidth)
                .opacity(0.3)
                .hidden(!timer.isTimerStarted)

            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(getGradientForFraction(gradient: gradientColor, fractionCompleted: fractionCompleted),
                        style: StrokeStyle(lineWidth: strokeWidth,
                                           lineCap: .round,
                                           lineJoin: .round))
                .rotationEffect(rotation)
                .animation(.easeInOut)
        }
    }
}
