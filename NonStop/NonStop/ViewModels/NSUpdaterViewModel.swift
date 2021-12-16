//
//  NSUpdaterViewModel.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.12.21.
//

import SwiftUI

class NSUpdaterViewModel: ObservableObject {

    // MARK: - variables

    @Published var now: Date = Date()
    private var timer: Timer?
    var timeInterval: TimeInterval = 5

    // MARK: - initialization

    init() {
        startTimer()
    }

    deinit {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - actions

    func refresh() {
        now = Date()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval,
                                     repeats: true,
                                     block: { _ in
            self.refresh()
        })
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
