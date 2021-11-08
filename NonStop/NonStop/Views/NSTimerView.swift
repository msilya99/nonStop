//
//  NSTimerView.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI

struct NSTimerView: View {

    // MARK: - variables

    private let progressSizeCoefficient = 0.65
    private let counterLabelSizeCoefficient = 0.6

    @EnvironmentObject var initialTimer: NSInitialTimer

    // MARK: - views

    var body: some View {
        ZStack(alignment: .center) {
            ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
                .progressViewStyle(NSGaugeProgressStyle(timer: initialTimer))
                .frame(width: SYS.screenSize.width * progressSizeCoefficient,
                       height: SYS.screenSize.width * progressSizeCoefficient)
                .padding()

            NSTimerCounterLabel(initialTimer: initialTimer)
                .frame(maxWidth: SYS.screenSize.width * counterLabelSizeCoefficient)
                .hidden(!initialTimer.isTimerStarted)
                .padding()
        }.onAppear {
            initialTimer.startTimer()
        }.onDisappear {
            initialTimer.stopTimer()
        }
    }
}
