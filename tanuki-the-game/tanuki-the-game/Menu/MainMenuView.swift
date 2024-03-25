//
//  MainMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 25/03/24.
//

import SwiftUI

struct MainMenuView: View {
    @State private var isGameViewPresented = false
    
    var body: some View {
        VStack {
            Text("Main Menu")
                .font(.title)
                .padding()
            
            Button("Start Game") {
                    self.isGameViewPresented = true
            }
            .padding()
            .sheet(isPresented: $isGameViewPresented) {
                GameViewControllerWrapper()
            }
            .transition(.blurReplace)
        }
    }
}

#Preview {
    MainMenuView()
}
