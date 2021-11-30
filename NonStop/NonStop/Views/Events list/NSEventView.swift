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
    var editEventAction: (() -> Void)
    var deleteEventAction: (() -> Void)
    
    @State private var showEditingMenu: Bool = false
    @State private var showDescription: Bool = false

    // MARK: - views body

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                HStack(alignment: .center) {
                    Text(event.selectedIcon)
                        .font(.system(size: 48))

                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.eventName)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(getMainColor())
                        Text(getTimeRangeString())
                            .foregroundColor(getDescriptionColor())
                    }
                    Spacer()

                    Text(getIntervalValueString())
                        .foregroundColor(getDescriptionColor())
                }

                if !event.eventDescription.isEmpty {
                    getAdditionalInfoView()
                }
            }

            getMenuView()
        }
        .padding()
        .background(getEventColor())
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: NSThemeColors.sh.getColorByType(.base02), radius: 2, x: 1, y: 1)
    }

    // MARK: - create menu view

    @ViewBuilder
    private func getMenuView() -> some View {
        Menu {
            Button() {
                editEventAction()
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button() {
                deleteEventAction()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(getMainColor())
        }
    }

    // MARK: - create additional info view

    @ViewBuilder
    private func getAdditionalInfoView() -> some View {
        DisclosureGroup("Show description", isExpanded: $showDescription) {
            Text(event.eventDescription)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(getDescriptionColor())
        }
        .accentColor(getMainColor())
        .font(.subheadline)
        .foregroundColor(getMainColor())
    }

    // MARK: - getter actions

    private func getTimeRangeString() -> String {
        guard let fromDate = event.fromDate, let toDate = event.toDate else {
            return ""
        }

        return Date.rangeFormat(start: fromDate,
                                end: toDate,
                                format: DateTimeFormat.hoursAndMinutes)
    }

    private func getIntervalValueString() -> String {
        guard let fromDate = event.fromDate, let toDate = event.toDate else {
            return ""
        }

        return Date.getDetailedIntervalValueString(toDate - fromDate,
                                                   withDay: event.isSpecialDateEvent)
    }

    private func getEventColor() -> Color {
        guard let colorDate = event.color,
              let color = Color.color(withData: colorDate) else {
                  return NSThemeColors.sh.getColorByType(.base)
              }
        return color
    }

    private func getMainColor() -> Color {
        NSBaseColors.sh.getColor(.base, isLightColor: getEventColor().isLightColor())
    }

    private func getDescriptionColor() -> Color {
        NSBaseColors.sh.getColor(.base02, isLightColor: getEventColor().isLightColor())
    }
}
