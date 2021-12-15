//
//  NSTimerView.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI

struct NSTimerView: View {

    // MARK: - variables

    @ObservedObject private var initialTimer: NSInitialTimer
    private let progressSizeCoefficient = 0.75
    @Binding var selectedEvent: Event?

    // MARK: - initialization

    init(selectedEvent: Binding<Event?>) {
        _selectedEvent = selectedEvent
        initialTimer = NSInitialTimer(selectedEvent: selectedEvent)
        initialTimer.startTimer()
    }

    // MARK: - views

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
                    .progressViewStyle(NSGaugeProgressStyle(timer: initialTimer))
                    .padding()

                NSTimerCounterLabel(initialTimer: initialTimer)
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
    }
}
