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
            VStack {
                NSAddEventSheetFormView()
            }
            .navigationTitle("New event")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button ("Cancel") {
                        shouldBeVisible = false
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        shouldBeVisible = false
                    }.disabled(true)
                }
            }
        }
        .accentColor(NSThemeColors.sh.getColorByType(.base))
    }
}
