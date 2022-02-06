//
//  GameView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameEngine: GameEngine

    private var flattenWords : [[String]] {
        gameEngine.trialWords.map { $0.map { String($0) } }
    }
    var body: some View {
        VStack {
            ForEach(0 ..< GameLayout.rows) { row in
                HStack {
                    ForEach(0 ..< GameLayout.columns) { column in
                        let char = getChar(at: row, column)
                        GameCardView(model: .init(char, highlight: row < gameEngine.currentRowIndex ? getColor(at: row, for: char) : GameColors.clear))
                    }
                }
            }
        }
    }

    func getColor(at row:Int, for char: String) -> Color {
        guard !char.isEmpty else { return Color.red }
        guard let checkWord = gameEngine.matchedChars[row] else { return Color.brown }
        let key = checkWord.first(where: { $0.value.lowercased() == char.lowercased() })!
        return key.color
    }

    func getChar(at row: Int,_ column: Int) -> String {
        let index = GameLayout.getIndex(row, column)
        return index < flattenWords.flatMap{$0}.count ? flattenWords[row][column] : ""
    }
}
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

extension GameView {
    struct GameCardView: View {
        let model: GameCardView.UIModel
        var body: some View {
            ZStack {
                ZStack {
                    Rectangle()
                        .stroke(model.strokeColor, lineWidth: 2)
                    Rectangle()
                        .fill(model.highlight)
                }
                .aspectRatio(1, contentMode: .fit)
                .transition(.scale)
                .animation(.easeInOut, value: model.value)

                Text(model.value)
                    .font(.title.weight(.black))
                    .textCase(.uppercase)
            }
        }
    }
}

extension GameView.GameCardView {
    struct UIModel {
        let value: String
        let strokeColor: Color
        let highlight: Color

        init(_ value: String, stroke: Color = GameColors.primary, highlight: Color) {
            self.value = value
            self.strokeColor = stroke
            self.highlight = highlight
        }
    }
}

