//
//  GameEngine.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import Foundation
import SwiftUI

class GameEngine: ObservableObject {
    private var matchedWord: String = "DAILY".lowercased()
    @Published var trialWords: [String] = Array(repeating: "", count: 6)
    @Published var matchedChars: [Int: [MatchedKey]] = [0:[]]
    @Published var hasMatched: Bool = false
    @Published var currentRowIndex = 0







    func getHighlightedKeys() -> [MatchedKey] {
        matchedChars.flatMap(\.value).sorted(by: >).removingDuplicates()
    }

    func getKeyHightlightColor(for key: String) -> Color {
        if let key = getHighlightedKeys().first(where: { $0.value.lowercased() == key.lowercased() }) {
            return key.color
        } else {
            return Color(.secondarySystemBackground)
        }
    }

    func handleKey(_ key: String) {
        if currentRowIndex == GameLayout.rows { return }
        guard trialWords[currentRowIndex].count < GameLayout.columns else { return }
        trialWords[currentRowIndex].append(key)

    }

    func deleteLastInput() {
        guard !trialWords[currentRowIndex].isEmpty else { return }
        trialWords[currentRowIndex].removeLast()
    }

    func performMatching() {
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
