//
//  NSTextEditor.swift
//  NonStop
//
//  Created by Ilya Maslou on 17.11.21.
//

import SwiftUI

struct NSTextEditor: View {

    // MARK: - variables

    @Binding var text: String
    var placeholder: String = "Enter description"

    var body: some View {

        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.primary.opacity(0.25))
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: .zero, trailing: .zero))
            }
            TextEditor(text: $text)
        }
    }
}
