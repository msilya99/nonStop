//
//  Emoji.swift
//  NonStop
//
//  Created by Ilya Maslou on 16.11.21.
//

struct Emoji: Decodable, Hashable {
    let emoji: String
    let category: String
    let aliases: [String]
}

extension Emoji {

    func isMatching(query: String) -> Bool {
        aliases.first(where: { $0.lowercased().contains(query.lowercased())}) != nil
    }
}
