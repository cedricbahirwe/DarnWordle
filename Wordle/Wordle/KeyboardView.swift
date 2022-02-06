//
//  KeyboardView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import SwiftUI

struct KeyboardView: View {
    @ObservedObject var gameEngine: GameEngine
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ForEach(GameContent.getKeyboardContent(), id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(row, id:\.self) { key in
                            Button {
                                gameEngine.handleKey(key)
                            } label: {
                                KeyboardKey(key, bg: gameEngine.getKeyHightlightColor(for: key))
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
        Button(action: gameEngine.performMatching) {
            Text("Enter")
                .textCase(.uppercase)
                .padding(5)
                .frame(width: 52, height: 60)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }

    var deleteButton: some View {
        Button(action: gameEngine.deleteLastInput) {
            Image(systemName: "delete.left")
                .frame(width: 50, height: 60)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
        }
    }

    struct KeyboardKey: View {
        private let key: String
        private var bg: Color
        init(_ key: String, bg: Color) {
            self.key = key
            self.bg = bg
        }
        var body: some View {
            Text(key)
                .textCase(.uppercase)
                .frame(width: 32, height: 60)
                .background(bg)
                .cornerRadius(5)
                .transition(.scale)
                .animation(.easeInOut, value: key)
        }
    }
}
//struct KeyboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyboardView()
//    }
//}
