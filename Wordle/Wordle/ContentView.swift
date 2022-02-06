//
//  ContentView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 05/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameEngine = GameEngine()
    @AppStorage("isUserFirstTime")
    private var isUserFirstTime: Bool = true
    @State private var showWelcomeView: Bool = false
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack {
                
                VStack {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .imageScale(.large)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                showWelcomeView = true
                            }
                        Spacer()
                        Text("Wordle")
                            .textCase(.uppercase)
                            .font(.title.weight(.heavy))
                        Spacer()
                    }
                    if gameEngine.hasMatched {
                        Text("Congratulations").bold().foregroundColor(.green)
                    }
#if DEB
                    Button(action: {
                        print(gameEngine.matchedChars)
                    }) {
                        Text("DEBUG: Matched Count: \(gameEngine.matchedChars.map(\.value).count.description)")
                            .lineLimit(2)
                            .foregroundColor(.red)
                    }
#endif
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
        .fullScreenCover(isPresented: $showWelcomeView, onDismiss: {
            isUserFirstTime = false
        }) {
            WelcomeView(isPresented: $showWelcomeView)
        }
        .onAppear {
            showWelcomeView = isUserFirstTime
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
