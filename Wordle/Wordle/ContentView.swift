//
//  ContentView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 05/02/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var matchedWord: String = "DAILY".lowercased()
    @State private var trialWords: [String] = Array(repeating: "", count: 6)
    @State private var matchedChars: [Int: [MatchedKey]] = [0:[]]
    @State private var hasMatched: Bool = false
    @State private var currentRowIndex = 0

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack {

                VStack {
                    Text("Wordle")
                        .textCase(.uppercase)
                        .font(.title.weight(.heavy))
                    if hasMatched {
                        Text("Congratulations").bold().foregroundColor(.green)
                    }
                    Button(action: {
                        print(matchedChars)
                    }) {
                        Text("DEBUG: Matched Count: \(matchedChars.map(\.value).count.description)")
                            .lineLimit(2)
                            .foregroundColor(.red)
                    }
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.thickMaterial, ignoresSafeAreaEdges: .top)

                GameView(words: trialWords,
                         matches: matchedChars,
                         index: currentRowIndex)

                KeyboardView(onKeyPressed: handleKey,
                             onDeletePressed: deleteInput,
                             onEnterPressed: performMatching)
                    .padding(.vertical, 30)
            }
            .foregroundColor(.primary)
        }
    }

    private func handleKey(_ key: String) {
        if currentRowIndex == GameLayout.rows { return }
        guard trialWords[currentRowIndex].count < GameLayout.columns else { return }
        trialWords[currentRowIndex].append(key)

    }
    private func deleteInput() {
        guard !trialWords[currentRowIndex].isEmpty else { return }
        trialWords[currentRowIndex].removeLast()
    }

    private func performMatching() {
        guard currentRowIndex < GameLayout.rows else { return }
        guard trialWords[currentRowIndex].count == GameLayout.columns else { return }

        for char in trialWords[currentRowIndex] {

            if matchedWord.lowercased().contains(char) {
                if let indexA = matchedWord.lowercased().firstIndex(of: char), let indexB = trialWords[currentRowIndex].lowercased().firstIndex(of: char) {
                    if indexA == indexB {
                        let key = MatchedKey(value: char, color:GameColors.matched)
                        matchedChars[currentRowIndex]?.append(key)
                    } else {
                        let key = MatchedKey(value: char, color: GameColors.inclusive)
                        matchedChars[currentRowIndex]?.append(key)
                    }
                }
            } else {
                print(char, matchedWord)
                let key = MatchedKey(value: char, color: GameColors.exclusive)
                matchedChars[currentRowIndex]?.append(key)
            }
        }
        hasMatched = trialWords[currentRowIndex].lowercased() == matchedWord.lowercased()

        currentRowIndex += 1
        matchedChars[currentRowIndex] = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
