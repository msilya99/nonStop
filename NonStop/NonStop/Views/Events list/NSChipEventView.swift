//
//  NSChipEventView.swift
//  NonStop
//
//  Created by Ilya Maslou on 2.12.21.
//

import SwiftUI

struct NSChipEventView: View {

    // MARK: - variables

    var title: String
    var eventColor: Color

    // MARK: - views

    var body: some View {
        Text(title)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(eventColor.getMainColor(isInverted: true))
            .clipShape(Capsule())
            .foregroundColor(eventColor.getMainColor())
            .overlay(Capsule().stroke(eventColor.getMainColor()))
    }
}
