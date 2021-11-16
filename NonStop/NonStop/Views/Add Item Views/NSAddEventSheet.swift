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
    @Binding var shouldBeVisible: Bool

    // MARK: - views

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                NSAddEventSheetFormView()
                NSPrimaryButton(title: "Save and add") {
                    print("Adding new element...")
                }
            }
            .navigationTitle("New event")
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
        .accentColor(NSThemeColors.sh.getColorByType(.base))
    }
}
