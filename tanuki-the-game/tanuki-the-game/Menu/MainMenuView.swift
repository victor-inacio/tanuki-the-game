//
//  MainMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 25/03/24.
//

import SwiftUI

struct MainMenuView: View {
    @State private var isGameViewActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isGameViewActive {
                    GameViewControllerWrapper()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 5), value: 10) // Add animation
                } else {
                    Text("Main Menu")
                        .font(.title)
                        .padding()
                    
                    Button(action: {
                        withAnimation {
                            self.isGameViewActive = true // Apply animation to state change
                        }
                    }) {
                        Text("Start Game")
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
}
