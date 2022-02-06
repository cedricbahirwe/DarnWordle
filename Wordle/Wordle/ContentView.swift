//
//  ContentView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 05/02/2022.
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

struct ContentView: View {
    @State private var matchedWord: String = "DAILY".lowercased()
    @State private var trialWords: [String] = Array(repeating: "", count: 6)
    @State private var matchedChars: [String: Color] = [:]

    @State private var currentRowIndex = 0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Wordle")
                    .textCase(.uppercase)
                    .font(.title.weight(.heavy))
                Button(action: {
                    print(matchedChars)
                }) {
                    Text("DeBUG")
                        .foregroundColor(.red)
                }
                GameView(words: trialWords,matches: matchedChars, index: currentRowIndex)

                KeyboardView(onKeyPressed: handleKey,
                             onDeletePressed: deleteInput,
                             onEnterPressed: performMatching)
                    .padding(.vertical, 30)
            }
            .foregroundColor(.white)
        }
    }

    private func handleKey(_ key: String) {
        if currentRowIndex == GameLayout.rows { fatalError() }
        guard trialWords[currentRowIndex].count < GameLayout.columns else { return }
        trialWords[currentRowIndex].append(key)

    }
    private func deleteInput() {
        guard !trialWords[currentRowIndex].isEmpty else { return }
        trialWords[currentRowIndex].removeLast()
    }

    private func performMatching() {
        guard trialWords[currentRowIndex].count == GameLayout.columns else { return }
        if currentRowIndex == GameLayout.rows { return }
        for char in trialWords[currentRowIndex] {

            if matchedWord.lowercased().contains(char) {
                if let indexA = matchedWord.lowercased().firstIndex(of: char), let indexB = trialWords[currentRowIndex].lowercased().firstIndex(of: char) {
                    if indexA == indexB {
                        matchedChars[String(char)] = GameColors.matched
                    } else {
                        matchedChars[String(char)] = GameColors.inclusive
                    }
                }
            } else {
                print(char, matchedWord)
                matchedChars[String(char)] =  GameColors.exclusive
            }
        }
        currentRowIndex += 1
            //        trialWords[currentRowIndex].lowercased() == matchedWord.lowercased()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameView: View {
    var words: [String]
    var matches: [String: Color]
    var index: Int
    var flattenWords : [[String]] {
        words.map { $0.map { String($0) } }
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
                                    .fill(row < index ? getColor(for: char) : Color.clear)
                            }
                            .aspectRatio(1, contentMode: .fit)

                            Text(char)
                                .font(.title)
                                .textCase(.uppercase)
                        }

                    }
                }
            }
        }
        .padding()

    }

    func getColor(for char: String) -> Color {
        guard !char.isEmpty else { return Color.red }
        return matches[char, default: Color.pink]
    }

    func getChar(at row: Int,_ column: Int) -> String {
        let index = GameLayout.getIndex(row, column)
        return index < flattenWords.flatMap{$0}.count ? flattenWords[row][column] : ""
    }
}

struct KeyboardView: View {
    var onKeyPressed: (String) -> Void
    var onDeletePressed: () -> Void
    var onEnterPressed: () -> Void
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ForEach(GameContent.getKeyboardContent(), id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(row, id:\.self) { key in
                            Button {
                                onKeyPressed(key)
                            } label: {
                                KeyboardKey(key, bg: .secondary)
                            }
                        }
                    }
                }
            }

            HStack {
                enterButton
                Spacer()
                deleteButton
            }
            .padding(.horizontal, 12)
        }
    }
    var enterButton: some View {
        Button(action: onEnterPressed) {
            Text("Enter")
                .textCase(.uppercase)
                .font(.body.weight(.semibold))
                .padding(5)
                .frame(width: 52, height: 40)
                .background(Color.secondary)
                .cornerRadius(5)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }

    var deleteButton: some View {
        Button(action: onDeletePressed) {
            Image(systemName: "delete.left")
                .font(.callout.weight(.semibold))
                .frame(width: 50, height: 40)
                .background(Color.secondary)
                .cornerRadius(5)
        }
    }

    struct KeyboardKey: View {
        private let key: String
        private var bg: Color
        init(_ key: String, bg: Color = Color.secondary) {
            self.key = key
            self.bg = bg
        }
        var body: some View {
            Text(key)
                .font(.callout.weight(.bold))
                .textCase(.uppercase)
                .frame(width: 32, height: 40)
                .background(Color.secondary)
                .cornerRadius(5)
                .transition(.scale)
                .animation(.easeInOut, value: key)
        }
    }
}
