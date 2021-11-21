//
//  NSEventView.swift
//  NonStop
//
//  Created by Ilya Maslou on 22.11.21.
//

import SwiftUI

struct NSEventView: View {

    // MARK: - variables

    var event: NSEventModel

    // MARK: - views body

    var body: some View {
        HStack(alignment: .center) {
            Text(event.selectedIcon)
                .font(.system(size: 48))

            VStack(alignment: .leading) {
                Text(event.eventName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(themeColorType: .baseInverted)
                Text(getIntervalValueString())
                    .foregroundColor(themeColorType: .base02Inverted)
            }
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .trailing) {
                        Text("From:")
                        Text("To:")
                    }
                    VStack(alignment: .trailing) {
                        Text(getTimeString(event.fromDate))
                        Text(getTimeString(event.toDate))
                    }
                }
                .foregroundColor(themeColorType: .base02Inverted)
            }
        }
        .padding()
        .backgroundColor(themeColorType: .base)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }

    // MARK: - actions

    private func getTimeString(_ date: Date?) -> String {
        return date?.toString(format: DateTimeFormat.hoursAndMinutes,
                              truncateLeadingZero: true) ?? ""
    }

    private func getIntervalValueString() -> String {
        guard let from = event.fromDate, let to = event.toDate else {
            return ""
        }

        return Date.getTimeStringForInterval(to - from,
                                             format: DateTimeFormat.hoursAndMinutes)
    }
}
