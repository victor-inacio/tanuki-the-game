//
//  DeathMenuView.swift
//  tanuki-the-game
//
//  Created by Luca on 01/04/24.
//

import SwiftUI

struct DeathMenuView: View {
    
    @Environment(Coordinator.self) private var coordinator
    
    var body: some View {
        Color.black
            .ignoresSafeArea(.all)
            .overlay(
                VStack{
                    Text("GAME OVER")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                        .bold()
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1)) { // Adjust duration as needed
                            coordinator.present(fullScreenCover: .mainMenu)
                        }
                    }) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.white)
                                .frame(width: 190, height: 60)
                            RoundedRectangle(cornerRadius: 17)
                                .foregroundStyle(.black)
                                .frame(width: 180, height: 50)
                            Text("Back to Menu")
                                .foregroundStyle(.white)
                                .font(.system(size:25))
                                .bold()
                        }
                    }
                    .padding()
                }
        )
    }
}

#Preview {
    DeathMenuView().environment(Coordinator())
}
