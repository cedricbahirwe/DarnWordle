//
//  ContentView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 05/02/2022.
//

import SwiftUI


typealias GameColors = Game.Colors
typealias GameLayout = Game.Layout
enum Game {
    enum Colors {
        static let primary = Color.gray
        static let inclusive = Color.yellow
        static let matched = Color.green
    }

    enum Layout {
        static let gameLayout = (rows: 6, columns: 5)

        static var columns: Int { gameLayout.columns }

        static var rows: Int { gameLayout.rows }
    }

}

struct ContentView: View {
    @State private var matchedWord: String = ""
    @State private var trialWords: [String] = []


    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Wordle")
                    .textCase(.uppercase)
                    .font(.title.weight(.heavy))

                VStack {
                    ForEach(0 ..< GameLayout.rows) { item in
                        HStack {
                            ForEach(0 ..< GameLayout.columns) { item in
                                HStack {
                                    Rectangle()
                                        .stroke(GameColors.primary)
                                        .aspectRatio(1, contentMode: .fit)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .foregroundColor(.white)
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
