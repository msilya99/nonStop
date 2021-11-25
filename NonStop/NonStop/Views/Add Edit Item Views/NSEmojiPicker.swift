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
    @State private var isSelectedChanged: Bool = false

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
                            .opacity(selectedEmoji == emoji.emoji ? 0.3 : 1)
                            .onTapGesture {
                                withAnimation {
                                    selectedEmoji = emoji.emoji
                                    isSelectedChanged.toggle()
                                }
                            }
                            Image(systemName: "checkmark")
                                .foregroundColor(themeColorType: .base)
                                .hidden(selectedEmoji != emoji.emoji)
                    }

                }
            }.padding()
        }
        .navigationTitle("Select icon")
    }
}
