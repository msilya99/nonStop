//
//  NSGaugeEllipseProgressStyle.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSGaugeEllipseProgressStyle: ProgressViewStyle {

    // MARK: - variables

    var strokeColor = Color.gray
    var strokeWidth = 5.0
    var rotation = Angle(degrees: 270)

    // MARK: - actions

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        return ZStack {
            Capsule()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor,
                        style: StrokeStyle(lineWidth:
                                            CGFloat(strokeWidth),
                                           lineCap: .round))
                .rotationEffect(rotation)
                .animation(.easeInOut, value: fractionCompleted)
        }
    }
}
