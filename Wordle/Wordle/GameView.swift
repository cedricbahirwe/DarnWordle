//
//  GameView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var gameEngine: GameEngine

    var flattenWords : [[String]] {
        gameEngine.trialWords.map { $0.map { String($0) } }
    }
    var body: some View {
        VStack {
            ForEach(0 ..< GameLayout.rows) { row in
                HStack {
                    ForEach(0 ..< GameLayout.columns) { column in
                        let char = getChar(at: row, column)
                        ZStack {
                            ZStack {
                                Rectangle()
                                    .stroke(GameColors.primary, lineWidth: 2)
                                Rectangle()
                                    .fill(row < gameEngine.currentRowIndex ? getColor(at: row, for: char) : Color.clear)
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .transition(.scale)
                            .animation(.easeInOut, value: char)

                            Text(char)
                                .font(.title.bold())
                                .textCase(.uppercase)
                        }
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
