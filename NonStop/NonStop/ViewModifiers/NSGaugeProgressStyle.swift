//
//  NSGaugeProgressStyle.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSGaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.blue
    var strokeWidth = 25.0
    var rotation: Angle = Angle(degrees: 270)
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor,
                        style: StrokeStyle(lineWidth:
                                            CGFloat(strokeWidth),
                                           lineCap: .round))
                .rotationEffect(rotation)
        } }
}
