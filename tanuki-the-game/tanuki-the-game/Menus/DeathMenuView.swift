//
//  DeathMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//

import SwiftUI

struct DeathMenuView: View {
    
    @Binding var currentView: CoordinatorViewType
    
    var body: some View {
        Color.black
            .ignoresSafeArea(.all)
            .overlay(
                VStack{
                    Text("GAME OVER")
                        .font(.custom("DarumaDropOne-Regular", size: 70))
                        .foregroundStyle(.white)
                        .bold()
                    
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.7)) {
                            self.currentView = .mainMenuView
                        }
                        
                    }) {
                            Text("Back to Menu")
                                .foregroundStyle(.white)
                                .font(.custom("DarumaDropOne-Regular", size: 25))
                                .bold()
                    }
                    .padding()
                }
        )
    }
}

//#Preview {
//    DeathMenuView().environment(Coordinator())
//}
