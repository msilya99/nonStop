//
//  NSTimerView.swift
//  NonStop
//
//  Created by Ilya Maslou on 3.11.21.
//

import SwiftUI

struct NSTimerView: View {
    @EnvironmentObject var initialTimerDate: NSInitialTimer
    
    var body: some View {
        Text("Timer started at \(initialTimerDate.getStartDateString()) \n Timer will end at \(initialTimerDate.getEndDateString()) \n Time till end: \(Date(timeIntervalSinceReferenceDate: initialTimerDate.timeRemain).toString(format: DateTimeFormat.fullTime))")
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .onAppear {
                initialTimerDate.startTimer()
            }
    }
}

struct NSTimerView_Previews: PreviewProvider {
    static var previews: some View {
        NSTimerView()
    }
}
