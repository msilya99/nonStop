//
//  NSWatterCircleAnimation.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSWatterCircleAnimationProgressView: View {

    // MARK: - variables

    @ObservedObject var initialTimer: NSInitialTimer

    private let progressSizeCoefficient = 0.65

    // MARK: - views

    var body: some View {
        NSCircleWaveView(initialTimer: initialTimer,
                         percent: initialTimer.timeLeftPersentage)
            .frame(width: SYS.screenSize.width * progressSizeCoefficient,
                   height: SYS.screenSize.width * progressSizeCoefficient)
            .padding()
            .onAppear {
                initialTimer.startTimer()
            }
            .onDisappear {
                initialTimer.stopTimer()
            }
    }
}

struct NSCircleWaveView: View {

    // MARK: - variables

    @ObservedObject var initialTimer: NSInitialTimer
    @State private var waveOffset = Angle(degrees: 0)

    let percent: Double

    // MARK: - view body

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("\(initialTimer.getTimeRemainString())")
                    .font(Font.system(size: 0.2 * min(geo.size.width, geo.size.height)))
                    .padding()
                Circle()
                    .stroke(Color.blue,
                            lineWidth: 0.025 * min(geo.size.width, geo.size.height))
                    .overlay(
                        NSWaveShape(offset: Angle(degrees: waveOffset.degrees),
                                    percent: Double(percent)/100)
                            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                            .clipShape(Circle().scale(0.94))
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                waveOffset = Angle(degrees: 360)
            }
        }
    }
}
