//
//  WelcomeView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 06/02/2022.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isPresented: Bool
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Text("HOW TO PLAY")
                    .font(.headline.bold())
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Image(systemName: "multiply")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                isPresented = false
                            }
                        , alignment: .trailing
                    )

                Text("Guess the **WORDLE** in 6 tries.\n\nEach guess must be a valid 5 letter word. Hit the enter button to submit.\n\nAfter each guess, the color of the tiles will change to show how close your guess was to the word.")

                Text("Examples").bold()

                getIntroView(keys: MatchedKey.welcomeIntro1,
                             description: "The letter W is in the word and in the correct spot.")

                getIntroView(keys: MatchedKey.welcomeIntro2,
                             description: "The letter I is in the word but in the wrong spot.")

                getIntroView(keys: MatchedKey.welcomeIntro3,
                             description: "The letter U is not in the word in any spot.")


                Text("A new WORDLE will be available each day!").bold()
            }
            .padding(10)
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }

    func getIntroView(keys: [MatchedKey], description: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ForEach(keys, id: \.date) { key in
                    GameView.GameCardView(model: key.toDomainModel())
                }
            }
            Text(description)
                .minimumScaleFactor(0.1)
                .lineSpacing(1)

        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isPresented: .constant(false))
            .environment(\.colorScheme, .dark)
    }
}
