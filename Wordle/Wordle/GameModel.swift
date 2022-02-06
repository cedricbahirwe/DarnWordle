//
//  GameModel.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import SwiftUI

protocol BaseModel {
    associatedtype Model
    func toDomainModel() -> Model
}
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
        static let clear = Color.clear
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

struct MatchedKey: Equatable, Comparable, Hashable, BaseModel {
    static func < (lhs: MatchedKey, rhs: MatchedKey) -> Bool {
        switch lhs.color {
        case GameColors.matched: return false
        case GameColors.inclusive: return rhs.color == GameColors.matched
        case GameColors.exclusive: return true
        default: return true
        }
    }

    init(_ value: Character, color: Color) {
        self.value = String(value)
        self.color = color
    }

    init(_ value: String, color: Color) {
        self.value = value
        self.color = color
    }

    let value: String
    let color: Color

    var date: Date { Date.now }
    static let empty = MatchedKey("", color: GameColors.primary)

    func toDomainModel() -> GameView.GameCardView.UIModel {
        .init(value, highlight: color)
    }

    static let welcomeIntro1: [MatchedKey] = [
        MatchedKey("W", color: GameColors.matched),
        MatchedKey("E", color: GameColors.clear),
        MatchedKey("A", color: GameColors.clear),
        MatchedKey("R", color: GameColors.clear),
        MatchedKey("Y", color: GameColors.clear),
    ]

    static let welcomeIntro2: [MatchedKey] = [
        MatchedKey("P", color: GameColors.clear),
        MatchedKey("I", color: GameColors.inclusive),
        MatchedKey("L", color: GameColors.clear),
        MatchedKey("L", color: GameColors.clear),
        MatchedKey("S", color: GameColors.clear),
    ]

    static let welcomeIntro3: [MatchedKey] = [
        MatchedKey("V", color: GameColors.clear),
        MatchedKey("A", color: GameColors.clear),
        MatchedKey("G", color: GameColors.clear),
        MatchedKey("U", color: GameColors.exclusive),
        MatchedKey("E", color: GameColors.clear),
    ]
}
