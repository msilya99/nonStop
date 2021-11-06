//
//  NSLineDotProgressStyle.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSLineDotProgressStyle: ProgressViewStyle {

    // MARK: - variables

    @ObservedObject var timer: NSInitialTimer

    var strokeColor = Color.red
    var strokeWidth: CGFloat = 10
    var rotation: Angle = Angle(degrees: 270)

    //  MARK: - actions

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted: CGFloat = configuration.fractionCompleted ?? 0

        ZStack {
            Circle()
                .stroke(strokeColor,
                        style: StrokeStyle(lineWidth: strokeWidth,
                                           dash: [7]))
                .rotationEffect(rotation)

            Circle()
                .trim(from: 0.0, to: fractionCompleted)
                .stroke(strokeColor,
                        style: StrokeStyle(lineWidth: strokeWidth,
                                           lineCap: .butt))
                .rotationEffect(rotation)
        }
    }
}
