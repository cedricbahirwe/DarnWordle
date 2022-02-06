//
//  ContentView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 05/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameEngine = GameEngine()
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack {

                VStack {
                    Text("Wordle")
                        .textCase(.uppercase)
                        .font(.title.weight(.heavy))
                    if gameEngine.hasMatched {
                        Text("Congratulations").bold().foregroundColor(.green)
                    }
                    Button(action: {
                        print(gameEngine.matchedChars)
                    }) {
                        Text("DEBUG: Matched Count: \(gameEngine.matchedChars.map(\.value).count.description)")
                            .lineLimit(2)
                            .foregroundColor(.red)
                    }
                }
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.thickMaterial, ignoresSafeAreaEdges: .top)

                GameView(gameEngine: gameEngine)
                    .animation(.spring(), value: gameEngine.hasMatched)

                KeyboardView(gameEngine: gameEngine)
                    .padding(.vertical, 30)
            }
            .foregroundColor(.primary)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
