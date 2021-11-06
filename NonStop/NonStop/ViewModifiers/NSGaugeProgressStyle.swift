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

    var strokeColor = Color.red
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
                    .foregroundColor(self.strokeColor)
            }

            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor,
                        style: StrokeStyle(lineWidth:
                                            CGFloat(strokeWidth),
                                           lineCap: .round,
                                           lineJoin: .round))
                .rotationEffect(rotation)
                .animation(.easeInOut)
        }
    }
}
