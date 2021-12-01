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
                            .foregroundColor(event.eventColor.getMainColor())
                        Text(getTimeRangeString())
                            .foregroundColor(event.eventColor.getAdditionalColor())
                    }
                    Spacer()

                    Text(getIntervalValueString())
                        .foregroundColor(event.eventColor.getAdditionalColor())
                }

                if !event.eventDescription.isEmpty {
                    getAdditionalInfoView()
                }
            }

            getMenuView()
        }
        .padding()
        .background(event.eventColor)
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
                .font(.system(size: 20))
                .foregroundColor(event.eventColor.getMainColor())
                .padding(.horizontal, 8)
                .padding(.bottom, 8)
        }
    }

    // MARK: - create additional info view

    @ViewBuilder
    private func getAdditionalInfoView() -> some View {
        DisclosureGroup("Show description", isExpanded: $showDescription) {
            Text(event.eventDescription)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(event.eventColor.getAdditionalColor())
        }
        .accentColor(event.eventColor.getMainColor())
        .font(.subheadline)
        .foregroundColor(event.eventColor.getMainColor())
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

        return Date.getHourAndMinuteIntervalString(toDate - fromDate,
                                                   withDays: event.isSpecialDateEvent)
    }
}
