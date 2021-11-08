//
//  NSDotStyleProgress.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSDotStyleProgressView: View {

    // MARK: - variables

    @ObservedObject var initialTimer: NSInitialTimer
    private let progressSizeCoefficient = 0.65
    private let counterLabelSizeCoefficient = 0.6

    var body: some View {
        ZStack(alignment: .center) {
            ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
                .progressViewStyle(NSLineDotProgressStyle(timer: initialTimer))
                .frame(width: SYS.screenSize.width * progressSizeCoefficient,
                       height: SYS.screenSize.width * progressSizeCoefficient)
                .padding()

            NSTimerCounterLabel(initialTimer: initialTimer, fontWeight: .medium)
                .frame(maxWidth: SYS.screenSize.width * counterLabelSizeCoefficient)
                .hidden(!initialTimer.isTimerStarted)
                .padding()
        }
        .onAppear {
            initialTimer.startTimer()
        }
        .onDisappear {
            initialTimer.stopTimer()
        }
    }
}
