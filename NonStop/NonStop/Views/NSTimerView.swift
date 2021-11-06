//
//  NSTimerView.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI

struct NSTimerView: View {
    @EnvironmentObject var initialTimer: NSInitialTimer
    
    var body: some View {
        VStack {
            NSCircleProgressView(initialTimer: initialTimer)
                .padding()
            Text("Timer started at \(initialTimer.getStartDateString()) \n Timer will end at \(initialTimer.getEndDateString()) \n Time till end: \(initialTimer.getTimeRemainString())")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
                .background(Color.black)
        }.onAppear {
            initialTimer.startTimer()
        }.onDisappear {
            initialTimer.stopTimer()
        }
    }
}

struct NSTimerView_Previews: PreviewProvider {
    static var previews: some View {
        NSTimerView()
    }
}
