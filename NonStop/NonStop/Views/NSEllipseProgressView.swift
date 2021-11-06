//
//  NSEllipseAnimation.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSEllipseProgressView: View {
    @EnvironmentObject var initialTimer: NSInitialTimer

    var body: some View {
        ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
            .progressViewStyle(NSGaugeEllipseProgressStyle(timer: initialTimer))
            .frame(width: 130, height: 200)
            .contentShape(Rectangle())
            .onAppear {
                initialTimer.startTimer()
            }
            .onDisappear {
                initialTimer.stopTimer()
            }
    }
}

struct NSEllipseAnimation_Previews: PreviewProvider {
    static var previews: some View {
        NSEllipseProgressView()
    }
}
