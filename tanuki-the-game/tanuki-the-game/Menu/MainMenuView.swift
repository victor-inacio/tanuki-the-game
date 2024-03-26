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
                        
                } else {
                    Text("Main Menu")
                        .font(.title)
                        .padding()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) { // Adjust duration as needed
                          self.isGameViewActive = true
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
