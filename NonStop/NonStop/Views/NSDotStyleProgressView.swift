//
//  NSDotStyleProgress.swift
//  NonStop
//
//  Created by Ilya Maslou on 6.11.21.
//

import SwiftUI

struct NSDotStyleProgressView: View {
    @ObservedObject var initialTimer: NSInitialTimer

    var body: some View {
        ProgressView(value: initialTimer.timeLeftPersentage, total: 100)
            .progressViewStyle(NSLineDotProgressStyle(timer: initialTimer))
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
