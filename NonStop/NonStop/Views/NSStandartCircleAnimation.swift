//
//  NSStandartCircleAnimation.swift
//  NonStop
//
//  Created by Ilya Maslou on 4.11.21.
//

import SwiftUI

struct NSStandartCircleAnimation: View {
    @EnvironmentObject var initialTimer: NSInitialTimer

    var body: some View {
        ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
            .progressViewStyle(NSGaugeProgressStyle())
            .frame(width: 200, height: 200)
            .contentShape(Rectangle())
            .onAppear {
                initialTimer.startTimer()
            }
            .onDisappear {
                initialTimer.stopTimer()
            }
    }
}

struct NSStandartCircleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        NSStandartCircleAnimation()
    }
}
