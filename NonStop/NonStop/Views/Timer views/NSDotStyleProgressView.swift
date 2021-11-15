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
    private let progressSizeCoefficient = 0.75

    // MARK: - views

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
                    .progressViewStyle(NSLineDotProgressStyle(timer: initialTimer))
                    .padding()

                NSTimerCounterLabel(initialTimer: initialTimer, fontWeight: .medium)
                    .hidden(!initialTimer.isTimerStarted)
                    .font(.system(size: initialTimer.getTimeRemainRatio() * geo.size.width,
                                  design: .rounded))
                    .padding()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(width: SYS.screenSize.width * progressSizeCoefficient,
               height: SYS.screenSize.width * progressSizeCoefficient,
               alignment: .center)
        .onAppear {
            initialTimer.startTimer()
        }
        .onDisappear {
            initialTimer.stopTimer()
        }
    }
}
