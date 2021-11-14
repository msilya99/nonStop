//
//  NSAddEventSheet.swift
//  NonStop
//
//  Created by Ilya Maslou on 14.11.21.
//

import SwiftUI

struct NSAddEventSheet: View {

    // MARK: - variables

    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var themeColors: NSThemeColors

    @Binding var shouldBeVisible: Bool

    // MARK: - views

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NSPrimaryButton(title: "Save and add") {
                    print("Adding new element...")
                }
            }
            .navigationTitle("Add new event")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        shouldBeVisible = false
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                    }
                }
            }
        }
        .accentColor(themeColors.getColorByType(.base))
    }
}
