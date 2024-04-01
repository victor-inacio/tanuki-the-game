//
//  DeathMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//

import SwiftUI

struct DeathMenuView: View {
    var body: some View {
        Color.black
            .ignoresSafeArea(.all)
            .overlay(
                VStack{
                    Text("GAME OVER")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                        .bold()
                }
        )
    }
}

#Preview {
    DeathMenuView()
}
