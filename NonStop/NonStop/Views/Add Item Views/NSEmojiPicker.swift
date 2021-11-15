//
//  NSEmojiPicker.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.11.21.
//

import SwiftUI

struct NSEmojiPicker: View {

    // MARK: - varaiables

    @Binding var selectedEmoji: String

    private let emojis: [Emoji] = EmojiLoadingManager().emojis
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    // MARK: - views

    var body: some View {
        ScrollView() {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(emojis, id: \.self) { emoji in
                    ZStack(alignment: .center) {
                        Text(emoji.emoji)
                            .font(.largeTitle)
                            .opacity(self.selectedEmoji == emoji.emoji ? 0.3 : 1)
                            .onTapGesture {
                                withAnimation {
                                    self.selectedEmoji = emoji.emoji
                                }
                            }
                        if selectedEmoji == emoji.emoji {
                            Image(systemName: "checkmark")
                                .foregroundColor(themeColorType: .base)
                        }
                    }

                }
            }.padding()
        }
        .navigationTitle("Select icon")
    }
}
