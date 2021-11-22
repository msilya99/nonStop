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
                    .foregroundColor(getTitleColor())
                Text(getIntervalValueString())
                    .foregroundColor(getDescriptionColor())
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
                .foregroundColor(getDescriptionColor())
            }
        }
        .padding()
        .background(getEventColor())
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: NSThemeColors.sh.getColorByType(.base02), radius: 1, x: 1, y: 1)
        .padding(.horizontal, 16)
    }

    // MARK: - getter actions

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

    private func getEventColor() -> Color {
        guard let colorDate = event.color,
              let color = Color.color(withData: colorDate) else {
                  return NSThemeColors.sh.getColorByType(.base)
              }
        return color
    }

    private func getTitleColor() -> Color {
        NSBaseColors.sh.getColor(.base, isLightColor: getEventColor().isLightColor())
    }

    private func getDescriptionColor() -> Color {
        NSBaseColors.sh.getColor(.base02, isLightColor: getEventColor().isLightColor())
    }
}
