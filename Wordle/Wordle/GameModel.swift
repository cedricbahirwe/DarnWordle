//
//  GameModel.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import SwiftUI

typealias GameColors = Game.Colors
typealias GameLayout = Game.Layout
typealias GameContent = Game.Content

enum Game {
    enum Content {
        static private let keyboard: [[String]] =
            [
                ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
                ["z", "x", "c", "v", "b", "n", "m"]
            ]

        static func getKeyboardContent() -> [[String]] {
            keyboard
        }
    }
    enum Colors {
        static let primary = Color.gray
        static let inclusive = Color.yellow
        static let exclusive = Color(.darkGray)
        static let matched = Color.green
    }

    enum Layout {
        static let gameLayout = (rows: 6, columns: 5)

        static var columns: Int { gameLayout.columns }

        static var rows: Int { gameLayout.rows }

        static func getIndex(_ row: Int, _ column: Int) -> Int {
            row * columns + column
        }
    }

}

struct MatchedKey {
    init(value: Character, color: Color) {
        self.value = String(value)
        self.color = color
    }

    init(value: String, color: Color) {
        self.value = value
        self.color = color
    }

    let value: String
    let color: Color
    static let empty = MatchedKey(value: "", color: GameColors.primary)
}
