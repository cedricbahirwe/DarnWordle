//
//  LogoView.swift
//  Wordle
//
//  Created by Cédric Bahirwe on 07/02/2022.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            Color(red: 0.102, green: 0.102, blue: 0.102)
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    Text("W")
                        .foregroundColor(.white)
                        .frame(width: 100)
                    Text("U")
                        .foregroundColor(.green)
                        .frame(width: 100)
                }

                HStack(spacing: 10) {
                    Text("N")
                        .foregroundColor(.yellow)
                        .frame(width: 100)

                    Text("O")
                        .foregroundColor(.gray)
                        .frame(width: 100)
                }

            }
            .font(.system(size: 100, weight: .black, design: .rounded))
            .frame(width: 250, height: 250)
            .scaleEffect(0.7)
            .overlay(Rectangle().stroke(Color.red))
            //                .fixedSize()
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
