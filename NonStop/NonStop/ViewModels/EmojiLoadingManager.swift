//
//  EmojiLoadingManager.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.11.21.
//

import UIKit

struct EmojiLoadingManager {

    // MARK: - variables

    var emojis: [Emoji] = []

    private let fileName: String = "emojis"
    private let fileExtension: String = "json"

    // MARK: - initialization

    init() { setEmojis() }

    // MARK: - setter

    private mutating func setEmojis() {
        guard let url = Bundle.main.url(forResource: fileName.description,
                                        withExtension: fileExtension.description),
              let data = try? Data(contentsOf: url) else {
            return
        }

        let emojis = try? JSONDecoder().decode([Emoji].self, from: data)
        self.emojis = emojis ?? []
    }
}
