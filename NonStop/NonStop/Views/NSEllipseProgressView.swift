//
//  NSEllipseAnimation.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSEllipseProgressView: View {

    // MARK: - variables
    
    @EnvironmentObject var initialTimer: NSInitialTimer

    private let progressHeightCoefficient = 0.65
    private let progressWidthCoefficient = 0.42
    private let counterLabelSizeCoefficient = 0.6

    // MARK: - views

    var body: some View {
        ZStack(alignment: .center) {
            ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
                .progressViewStyle(NSGaugeEllipseProgressStyle(timer: initialTimer))
                .frame(width: SYS.screenSize.width * progressWidthCoefficient,
                       height: SYS.screenSize.width * progressHeightCoefficient)
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
