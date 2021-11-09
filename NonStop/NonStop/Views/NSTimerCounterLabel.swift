//
//  NSTimerCounterLabel.swift
//  NonStop
//
//  Created by Ilya Maslou on 9.11.21.
//

import SwiftUI

struct NSTimerCounterLabel: View {

    // MARK: - variables

    @ObservedObject var initialTimer: NSInitialTimer
    var fontWeight: Font.Weight = .bold

    // MARK: - view actions

    var body: some View {
        Text("\(initialTimer.getTimeRemainString())")
            .fontWeight(fontWeight)
            .padding()
            .lineLimit(1)
            .frame(alignment: .center)
            .minimumScaleFactor(0.01)
    }
}
